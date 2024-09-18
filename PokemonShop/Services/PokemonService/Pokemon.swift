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
    
    convenience init(_ item: PokemonModel) {
        self.init(
            id: item.id,
            name: item.name
        )
    }

    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool { lhs.id == rhs.id }

    func hash(into hasher: inout Hasher) { hasher.combine(id) }

    func fetchImage(service: ImageService) async throws -> UIImage? {
        var folderName: String { "Pokemon_data_folder" }
        var dataName: String { "pokemon_image_\(id)" }
        var request: PokemonImageHTTPRequest {
            PokemonImageHTTPRequest(
                servicePath: "/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
            )
        }
        
        return try await service.fetchImage(
            folderName: folderName,
            dataName: dataName,
            request: request
        )
    }
}
