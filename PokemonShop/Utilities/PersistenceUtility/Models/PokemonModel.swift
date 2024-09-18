import Foundation
import SwiftData

@Model 
final class PokemonModel {
    @Attribute(.unique)
    let id: String
    
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
