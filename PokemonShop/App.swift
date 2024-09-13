import SwiftUI

@main
struct App: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authenticationService = AuthenticationService()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                SignInView()
            }
            .environmentObject(authenticationService)
        }
    }
}
