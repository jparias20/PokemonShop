import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var alertConfig: CustomAlertConfig?
    @State private var isSignUpPresented: Bool = false

    @EnvironmentObject private var authenticationService: AuthenticationService
        
    var body: some View {
        VStack {
            Spacer()
            HeaderView()
            AuthenticationTextFieldsView(email: $email, password: $password)
            MainButtonView(title: "Sign In") { signIn() }
            Spacer()
            FooderView(isSignUpPresented: $isSignUpPresented)
        }
        .padding()
        .loadingView(isPresented: $isLoading)
        .customAlertView(item: $alertConfig)
        .sheet(isPresented: $isSignUpPresented) { SignUpView() }
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

private struct FooderView: View {
    @Binding var isSignUpPresented: Bool
    
    var body: some View {
        Text("If you don't have an account")
            .font(.footnote)
        Button {
            isSignUpPresented = true
        } label: {
            Text("Sign Up")
                .bold()
                .font(.footnote)
                .foregroundStyle(.green)
        }
    }
}

#Preview {
    SignInView()
        .environmentObject(AuthenticationService())
}
