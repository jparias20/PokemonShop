import Foundation
import UIKit

final class Pokemon: ObservableObject, Identifiable {
    let id: String
    let name: String
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    
    convenience init?(_ item: PokemonResponse) {
        guard let id: Substring = item.url.split(separator: "/").last else { return nil }
        self.init(name: item.name, id: "\(id)")
    }
    
    func fetchImage(service: ImageService) async -> UIImage? {
        var folderName: String { "Pokemon_data_folder" }
        var dataName: String { "pokemon_image_\(id)" }
        var request: PokemonImageHTTPRequest {
            PokemonImageHTTPRequest(
                servicePath: "/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
            )
        }
        
        do {
            return try await service.fetchImage(
                folderName: folderName,
                dataName: dataName,
                request: request
            )
        } catch {
            return nil
        }
    }
}

extension Pokemon: Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
}

extension Pokemon: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
