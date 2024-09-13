import Foundation

protocol AuthenticationUtility {
    func signUp(_ email: String, password: String) async throws -> User
    func signIn(_ email: String, password: String) async throws -> User
}

enum AuthenticationUtilityError: Error {
    case accountNotFound
    case emailAlreadyInUse
    case invalidEmail
    case weakPassword
    case wrongPassword
    case undefined
    case userNoFound
    
    var message: String {
        switch self {
        case .accountNotFound: return "There is no any account."
        case .emailAlreadyInUse: return "Email used to attempt a sign up is already in use."
        case .invalidEmail: return "Email is invalid."
        case .weakPassword: return "Password is too weak, try a new one."
        case .wrongPassword: return "Credentials are wrong"
        case .undefined: return "Undefined error."
        case .userNoFound: return "User Account Was Not Found"
        }
    }
    
    init(firbaseCode code: Int) {
        switch code {
        case 17011:
            self = .accountNotFound
        case 17007:
            self = .emailAlreadyInUse
        case 17008:
            self = .invalidEmail
        case 17009:
            self = .wrongPassword
        case 17026:
            self = .weakPassword
        default:
            self = .undefined
        }
    }
}
