import Firebase
import FirebaseAuth
import FirebaseFirestore
import Foundation

struct FirebaseUtility: AuthenticationUtility {
    private var firestore: Firestore { Firestore.firestore() }
    
    func fetchUser() async throws -> User? {
        guard let currentUser: FirebaseAuth.User = Auth.auth().currentUser else { return nil }
        guard let email = currentUser.email else { throw AuthenticationUtilityError.userNoFound }

        let uid: String = currentUser.uid
        let name: String? = currentUser.displayName
        return User(email: email, uid: uid, name: name)
    }

    func signUp(_ email: String, password: String) async throws -> User {
        do {
            let response: AuthDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = User(email: email, uid: response.user.uid)
            _ = try await firestore.collection("users").addDocument(data: ["email": user.email])
            
            return user
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
