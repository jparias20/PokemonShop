import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var alertConfig: CustomAlertConfig?
    @State private var interactiveDismissDisabled: Bool = false
    
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
        .padding()
        .interactiveDismissDisabled(interactiveDismissDisabled)
        .loadingView(isPresented: $isLoading)
        .customAlertView(item: $alertConfig)
    }
    
    private func signUp() {
        Task { @MainActor in
            defer {
                isLoading = false
                interactiveDismissDisabled = false
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
                interactiveDismissDisabled = true
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
