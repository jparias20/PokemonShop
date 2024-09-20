import Foundation
import UIKit

final class ImageService: ObservableObject {
    private let localFileUtility: LocalFileUtility
    private let networkingUtility: NetworkingUtility

    init(
        localFileUtility: LocalFileUtility = LocalFileUtilityImpl.shared,
        networkingUtility: NetworkingUtility = HTTPClientProvider.shared
    ) {
        self.localFileUtility = localFileUtility
        self.networkingUtility = networkingUtility
    }
    
    func fetchImage(_ pokemon: Pokemon) async throws -> UIImage {
        let folderName: String = "Pokemon_data_folder"
        let dataName: String = "pokemon_image_\(pokemon.id)"
        
        if let data: Data = await localFileUtility.fetch(name: dataName, folderName: folderName),
           let image = UIImage(data: data) {
            return image
        }
        
        let path: String = "/PokeAPI/sprites/master/sprites/pokemon/\(pokemon.id).png"
        let request = PokemonImageHTTPRequest(servicePath: path)
        
        let data: Data = try await networkingUtility.sendRequest(request: request)
        guard let image = UIImage(data: data) else { throw ImageServiceError.noImage }
        await localFileUtility.save(data, name: dataName, folderName: folderName)
        return image
    }
}
