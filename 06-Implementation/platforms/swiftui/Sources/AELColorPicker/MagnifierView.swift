import SwiftUI

/// Pixel magnifier with two rendering modes:
///  - **Precision** (`precision == true`): nearest-neighbor upscaling with a
///    pixel grid, so individual pixels are clearly visible.
///  - **Smooth**: high-quality interpolation, for reading gradients.
struct MagnifierView: View {
    let image: CGImage?
    let precision: Bool
    let zoom: CGFloat

    var body: some View {
        Canvas { context, size in
            guard let image else { return }

            let source: CGImage = precision
                ? Self.nearestNeighborScaled(image, scale: Int(zoom))
                : image

            context.draw(
                Image(decorative: source, scale: 1),
                in: CGRect(origin: .zero, size: size)
            )

            if precision {
                drawGrid(in: &context, size: size, pixelCount: CGFloat(image.width))
            }
            drawCrosshair(in: &context, size: size)
        }
    }

    /// Exact integer upscale with no interpolation — each source pixel becomes
    /// a `scale × scale` block of identical pixels (crisp precision mode).
    private static func nearestNeighborScaled(_ image: CGImage, scale: Int) -> CGImage {
        let width = image.width * scale
        let height = image.height * scale
        guard width > 0, height > 0,
              let space = CGColorSpace(name: CGColorSpace.sRGB),
              let context = CGContext(
                  data: nil,
                  width: width,
                  height: height,
                  bitsPerComponent: 8,
                  bytesPerRow: 0,
                  space: space,
                  bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
                      | CGBitmapInfo.byteOrder32Big.rawValue
              ) else { return image }
        context.interpolationQuality = .none
        context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
        return context.makeImage() ?? image
    }

    private func drawGrid(in context: inout GraphicsContext, size: CGSize, pixelCount: CGFloat) {
        let step = size.width / pixelCount
        var path = Path()

        var x = step
        while x < size.width - 0.5 {
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: size.height))
            x += step
        }
        var y = step
        while y < size.height - 0.5 {
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: size.width, y: y))
            y += step
        }

        context.stroke(path, with: .color(.black.opacity(0.28)), lineWidth: 0.5)
    }

    private func drawCrosshair(in context: inout GraphicsContext, size: CGSize) {
        let cx = size.width / 2
        let cy = size.height / 2
        let gap: CGFloat = max(1.5, zoom * 0.45)

        var path = Path()
        path.move(to: CGPoint(x: 0, y: cy))
        path.addLine(to: CGPoint(x: cx - gap, y: cy))
        path.move(to: CGPoint(x: cx + gap, y: cy))
        path.addLine(to: CGPoint(x: size.width, y: cy))
        path.move(to: CGPoint(x: cx, y: 0))
        path.addLine(to: CGPoint(x: cx, y: cy - gap))
        path.move(to: CGPoint(x: cx, y: cy + gap))
        path.addLine(to: CGPoint(x: cx, y: size.height))

        // Dark halo for visibility on any luminance, white core on top.
        context.stroke(path, with: .color(.black.opacity(0.55)), lineWidth: 3)
        context.stroke(path, with: .color(.white), lineWidth: 1)
    }
}
