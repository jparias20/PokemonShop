import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var alertConfig: CustomAlertConfig?
        
    var body: some View {
        VStack {
            Spacer()
            HeaderView()
            TextFieldsView(email: $email, password: $password)
            MainButtonView(title: "Sign In") { signIn() }
            Spacer()
            Text("Create a new acount")
                .font(.footnote)
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

private struct TextFieldsView: View {
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Enter Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
            
            SecureField("Enter Password", text: $password)
                .textFieldStyle(.roundedBorder)
        }
        .padding(.vertical)
    }
}

#Preview {
    SignInView()
        .environmentObject(AuthenticationService())
}
