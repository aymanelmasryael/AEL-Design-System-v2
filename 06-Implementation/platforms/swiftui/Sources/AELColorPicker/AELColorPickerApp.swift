import SwiftUI

@main
struct AELColorPickerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup("AEL Color Picker") {
            ColorPanelView()
                .environmentObject(appDelegate.appState)
        }
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 400, height: 640)
    }
}
