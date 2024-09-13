import Firebase
import FirebaseAuth
import Foundation

final class FirebaseUtility: AuthenticationUtility {
    func signUp(_ email: String, password: String) async throws -> User {
        do {
            let response: AuthDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            return User(email: email, uid: response.user.uid)
        } catch {
            throw AuthenticationUtilityError(firbaseCode: error._code)
        }
    }
    
    func signIn(_ email: String, password: String) async throws -> User {
        do {
            let response: AuthDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
            return User(email: email, uid: response.user.uid)
        } catch {
            throw AuthenticationUtilityError(firbaseCode: error._code)
        }
    }
}
