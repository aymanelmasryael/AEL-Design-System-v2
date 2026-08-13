import AppKit
import Carbon.HIToolbox

/// Global hotkey registration using the Carbon Event Manager.
/// Binds ⌘⇧P to start a pick (and toggles to cancel if already picking).
final class HotKeyManager {

    private static var pressedHandler: (() -> Void)?
    private var hotKeyRef: EventHotKeyRef?

    @discardableResult
    func register(
        keyCode: UInt32 = UInt32(kVK_ANSI_P),
        modifiers: UInt32 = UInt32(cmdKey | shiftKey),
        handler: @escaping () -> Void
    ) -> Bool {
        Self.pressedHandler = handler

        var eventType = EventTypeSpec(
            eventClass: OSType(kEventClassKeyboard),
            eventKind: UInt32(kEventHotKeyPressed)
        )

        let installStatus = InstallEventHandler(
            GetApplicationEventTarget(),
            { _, _, _ -> OSStatus in
                DispatchQueue.main.async { HotKeyManager.pressedHandler?() }
                return noErr
            },
            1,
            &eventType,
            nil,
            nil
        )
        guard installStatus == noErr else { return false }

        let hotKeyID = EventHotKeyID(signature: OSType(0x41454C50), id: 1)
        let registerStatus = RegisterEventHotKey(
            keyCode,
            modifiers,
            hotKeyID,
            GetApplicationEventTarget(),
            0,
            &hotKeyRef
        )
        return registerStatus == noErr
    }

    deinit {
        if let hotKeyRef {
            UnregisterEventHotKey(hotKeyRef)
        }
    }
}
