import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var authenticationService: AuthenticationService

    @State private var isViewPresented: Bool = false
    @State private var isLoading: Bool = true

    var body: some View {
        VStack {
            if isViewPresented {
                SignInView()
            }
        }
        .loadingView(isPresented: $isLoading)
        .onAppear { fetchUser() }
    }
    
    private func fetchUser() {
        Task { @MainActor in
            await authenticationService.fetchUser()
            guard authenticationService.user == nil else { return }
            isViewPresented = true
            isLoading = false
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(AuthenticationService())
}
