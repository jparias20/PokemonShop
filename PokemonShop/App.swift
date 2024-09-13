import SwiftUI

@main
struct App: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authenticationService = AuthenticationService()

    var body: some Scene {
        WindowGroup {
            Group {
                switch authenticationService.user {
                case .none:
                    SplashView()
                case .some:
                    Text("There is user")
                }
            }
            .environmentObject(authenticationService)
        }
    }
}
