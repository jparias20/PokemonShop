import Foundation

actor User: ObservableObject {
    let email: String
    let uid: String
    var name: String?
    
    init(email: String, uid: String, name: String? = nil) {
        self.email = email
        self.uid = uid
        self.name = name
    }
}
