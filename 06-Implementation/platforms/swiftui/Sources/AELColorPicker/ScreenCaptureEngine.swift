import AppKit
import CoreGraphics
import Combine
import AELColorKit

/// Screen capture engine.
///
/// Design notes (matching the ColorSlurp-class architecture):
///  - Pixels are read through the Core Graphics window server snapshot API
///    (`CGWindowListCreateImage`), never from a framebuffer directly.
///  - Mouse motion is observed with `NSEvent.addGlobalMonitorForEvents`
///    (Observer pattern) and throttled to ~60 fps with frame dropping.
///  - Coordinates: `CGEvent.location` uses the top-left-origin global display
///    space (the same space `CGWindowListCreateImage` expects), which keeps
///    multi-display capture correct without manual mapping.
final class ScreenCaptureEngine: ObservableObject {

    @Published var capturedRegion: CGImage?
    @Published var cursorPoint: CGPoint = .zero
    @Published var cursorScreenPoint: NSPoint = .zero
    @Published var isMonitoring = false
    @Published var lastCaptureDuration: TimeInterval = 0

    /// The region half-size in points. 7 → a 15×15 point window.
    var regionRadius = 7

    private var globalMonitors: [Any] = []
    private var localMonitors: [Any] = []
    private var lastFrameTime: TimeInterval = 0
    private var didPickThisSession = false

    var onMouseMoved: ((AELColor) -> Void)?
    var onPick: ((AELColor) -> Void)?
    var onCancel: (() -> Void)?

    // MARK: - Permission

    func hasScreenRecordingPermission() -> Bool {
        CGPreflightScreenCaptureAccess()
    }

    @discardableResult
    func requestScreenRecordingPermission() -> Bool {
        CGRequestScreenCaptureAccess()
    }

    // MARK: - Monitoring

    func startMonitoring() {
        guard globalMonitors.isEmpty else { return }
        didPickThisSession = false
        lastFrameTime = 0

        let mouseMoved: @Sendable (NSEvent) -> Void = { [weak self] _ in
            self?.handleMouseMoved()
        }
        let mouseDown: @Sendable (NSEvent) -> Void = { [weak self] _ in
            self?.handlePick()
        }
        let keyDown: @Sendable (NSEvent) -> Void = { [weak self] event in
            // keyCode 53 == escape
            if event.keyCode == 53 { self?.onCancel?() }
        }

        globalMonitors.append(
            NSEvent.addGlobalMonitorForEvents(matching: [.mouseMoved, .leftMouseDragged, .rightMouseDragged], handler: mouseMoved)!
        )
        globalMonitors.append(
            NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown, handler: mouseDown)!
        )
        globalMonitors.append(
            NSEvent.addGlobalMonitorForEvents(matching: .keyDown, handler: keyDown)!
        )

        // Local monitors so clicks/esc land even when the floating overlay
        // (a window of this app) is technically frontmost.
        localMonitors.append(
            NSEvent.addLocalMonitorForEvents(matching: .leftMouseDown, handler: { [weak self] event in
                self?.handlePick()
                return event
            })!
        )
        localMonitors.append(
            NSEvent.addLocalMonitorForEvents(matching: .keyDown, handler: { [weak self] event in
                if event.keyCode == 53 { self?.onCancel?() }
                return event
            })!
        )

        isMonitoring = true
        handleMouseMoved(force: true)
    }

    func stopMonitoring() {
        globalMonitors.forEach { NSEvent.removeMonitor($0) }
        localMonitors.forEach { NSEvent.removeMonitor($0) }
        globalMonitors.removeAll()
        localMonitors.removeAll()
        isMonitoring = false
    }

    // MARK: - Capture

    private func handleMouseMoved(force: Bool = false) {
        let now = ProcessInfo.processInfo.systemUptime
        guard force || (now - lastFrameTime) >= (1.0 / 60.0) else { return }
        lastFrameTime = now

        guard let location = CGEvent(source: nil)?.location else { return }
        cursorPoint = location
        cursorScreenPoint = NSEvent.mouseLocation

        let start = CFAbsoluteTimeGetCurrent()
        let region = captureRegion(around: location, radius: regionRadius)
        capturedRegion = region
        lastCaptureDuration = CFAbsoluteTimeGetCurrent() - start

        if let pixel = pixelColor(centerOf: region) {
            onMouseMoved?(pixel)
        }
    }

    private func handlePick() {
        guard !didPickThisSession else { return }
        guard let pixel = pixelColor(centerOf: capturedRegion) else { return }
        didPickThisSession = true
        onPick?(pixel)
    }

    /// Captures a point-aligned sub-region of the screen around `point`.
    /// `CGWindowListCreateImage` accepts a rect in the top-left-origin global
    /// display space and — with `.bestResolution` — returns device-resolution
    /// pixels (2×/3× on Retina).
    func captureRegion(around point: CGPoint, radius: Int) -> CGImage? {
        let side = CGFloat(radius * 2 + 1)
        let rect = CGRect(
            x: point.x - CGFloat(radius),
            y: point.y - CGFloat(radius),
            width: side,
            height: side
        )
        return CGWindowListCreateImage(
            rect,
            .optionIncludingWindow,
            kCGNullWindowID,
            [.bestResolution, .boundsIgnoreFraming]
        )
    }

    /// Reads the exact pixel at the center of the captured region, converting
    /// it into sRGB through a color-managed bitmap context.
    func pixelColor(centerOf image: CGImage?) -> AELColor? {
        guard let image else { return nil }
        return pixelColor(from: image, at: CGPoint(x: image.width / 2, y: image.height / 2))
    }

    func pixelColor(from image: CGImage, at point: CGPoint) -> AELColor? {
        let x = Int(point.x)
        let y = Int(point.y)
        guard x >= 0, y >= 0, x < image.width, y < image.height else { return nil }

        var pixel = [UInt8](repeating: 0, count: 4)
        guard let space = CGColorSpace(name: CGColorSpace.sRGB),
              let context = CGContext(
                  data: &pixel,
                  width: 1,
                  height: 1,
                  bitsPerComponent: 8,
                  bytesPerRow: 4,
                  space: space,
                  bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
                      | CGBitmapInfo.byteOrder32Big.rawValue
              ) else { return nil }

        context.setBlendMode(.copy)
        context.interpolationQuality = .none
        context.translateBy(x: -CGFloat(x), y: -CGFloat(y))
        context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))

        let alpha = Double(pixel[3]) / 255.0
        guard alpha > 0 else { return AELColor(red: 0, green: 0, blue: 0, alpha: 0) }
        return AELColor(
            red: Double(pixel[0]) / 255.0 / alpha,
            green: Double(pixel[1]) / 255.0 / alpha,
            blue: Double(pixel[2]) / 255.0 / alpha,
            alpha: alpha
        )
    }
}
