import SwiftUI

@main
struct Mirai_KakeboApp: App {

    @State private var progressViewModel =
        ProgressViewModel()

    @State private var accessibilitySettings =
        AccessibilitySettings()

    var body: some Scene {

        WindowGroup {

            MainTabView()
                .environment(
                    progressViewModel
                )
                .environment(
                    accessibilitySettings
                )
        }
    }
}
