import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Spacer()
            HeaderView()
            TextFieldsView(email: $email, password: $password)
            MainButtonView(title: "Sign In") {
                
            }
            Spacer()
            Text("Create a new acount")
                .font(.footnote)
        }
        .padding()
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
        VStack {
            TextField("Enter Email", text: $email)
                .keyboardType(.emailAddress)
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
}
