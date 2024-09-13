import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var alertConfig: CustomAlertConfig?
    
    @EnvironmentObject private var authenticationService: AuthenticationService
        
    var body: some View {
        VStack {
            Spacer()
            HeaderView()
            AuthenticationTextFieldsView(email: $email, password: $password)
            MainButtonView(title: "Sign Up") { signUp() }
            Spacer()
            Text("Create a new acount")
                .font(.footnote)
        }
        .loadingView(isPresented: $isLoading)
        .customAlertView(item: $alertConfig)
        .padding()
    }
    
    private func signUp() {
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
                try await authenticationService.signUp(email, password: password)
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

            Text("Sign Up")
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthenticationService())
}
