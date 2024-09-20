import Foundation
import UIKit

final class Pokemon: ObservableObject, Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    
    var nameFormatted: String { name.capitalized }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    convenience init?(_ item: PokemonResponse) {
        guard let id: Substring = item.url.split(separator: "/").last else { return nil }
        self.init(
            id: "\(id)",
            name: item.name
        )
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool { lhs.id == rhs.id }

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}
