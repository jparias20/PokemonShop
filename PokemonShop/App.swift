import SwiftUI

@main
struct App: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authenticationService = AuthenticationService()
    @StateObject private var imageService = ImageService()

    var body: some Scene {
        WindowGroup {
            Group {
                switch authenticationService.user {
                case .none:
                    SplashView()
                case .some:
                    HomeView()
                }
            }
            .environmentObject(authenticationService)
            .environmentObject(imageService)
        }
    }
}
