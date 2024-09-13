import SwiftUI

struct AuthenticationTextFieldsView: View {
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
    AuthenticationTextFieldsView(email: .constant(""), password: .constant(""))
}
