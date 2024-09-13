import Foundation

final class AuthenticationService: ObservableObject {
    private let authenticationUtility: AuthenticationUtility
    
    @Published private(set) var user: User?
    
    init(authenticationUtility: AuthenticationUtility = FirebaseUtility()) {
        self.authenticationUtility = authenticationUtility
    }
    
    @MainActor
    func signUp(_ email: String, password: String) async throws {
        user = try await authenticationUtility.signUp(email, password: password)
    }
    
    @MainActor
    func signIn(_ email: String, password: String) async throws {
        user = try await authenticationUtility.signIn(email, password: password)
    }
}
