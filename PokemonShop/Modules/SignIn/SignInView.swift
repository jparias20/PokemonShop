import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var alertConfig: CustomAlertConfig?
    
    @EnvironmentObject private var authenticationService: AuthenticationService
        
    var body: some View {
        VStack {
            HeaderView()
            AuthenticationTextFieldsView(email: $email, password: $password)
            MainButtonView(title: "Sign In") { signIn() }
        }
        .loadingView(isPresented: $isLoading)
        .customAlertView(item: $alertConfig)
        .padding()
    }
    
    private func signIn() {
        Task { @MainActor in
            defer {
                isLoading = false
            }
            
            do {
                if email.isEmpty {
                    alertConfig = CustomAlertConfig(message: "An Email is required")
                    return
                }
                
                if password.isEmpty {
                    alertConfig = CustomAlertConfig(message: "A Password is required")
                    return
                }
                
                isLoading = true
                try await authenticationService.signIn(email, password: password)
            } catch let error as AuthenticationUtilityError {
                alertConfig = CustomAlertConfig(message: error.message)
            }
        }
    }
}

private struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Welcome to PokemonShop")
                .font(.title)
                .bold()

            Text("Sign in")
        }
    }
}

#Preview {
    SignInView()
        .environmentObject(AuthenticationService())
}
