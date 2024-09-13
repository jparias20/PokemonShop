import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var authenticationService: AuthenticationService

    @State private var isViewPresented: Bool = false
    @State private var isLoading: Bool = true
    @State private var isSignInPresented: Bool = false
    @State private var isSignUpPresented: Bool = false

    var body: some View {
        VStack {
            if isViewPresented {
                Text("Welcome to PokemonShop")
                    .font(.title)
                    .bold()
                
                HStack {
                    MainButtonView(title: "Sign In") { isSignInPresented = true }
                    MainButtonView(title: "Sign Up") { isSignUpPresented = true }
                }
            }
        }
        .padding()
        .sheet(isPresented: $isSignInPresented) { SignInView() }
        .sheet(isPresented: $isSignUpPresented) { SignUpView() }
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
