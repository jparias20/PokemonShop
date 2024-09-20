import Foundation
import NetworkingFramework
import UIKit

final class PokemonService: ObservableObject {
    private let networkingUtility: NetworkingUtility
    private let persistenceUtility: PersistenceUtility
    private let limit: Int
    private var offset: Int
    
    init(
        networkingUtility: NetworkingUtility = HTTPClientProvider(
            httpClient: HTTPClientImpl(urlSession: URLSessionImpl(configuration: .ephemeral))
        ),
        persistenceUtility: PersistenceUtility = CoreDataProvider.shared
    ) {
        self.offset = 0
        self.limit = 20
        self.networkingUtility = networkingUtility
        self.persistenceUtility = persistenceUtility
    }
    
    func fetchPokemons() async -> [Pokemon] {
        do {
            let overrideDefaultHeaders = ["offset": "\(offset)", "limit": "\(limit)"]
            let request = PokemonHTTPRequest(servicePath: "/api/v2/pokemon", overrideDefaultHeaders: overrideDefaultHeaders)
            let response: PokemonFetchResponse = try await networkingUtility.sendRequest(request: request)
            offset += limit
            let items: [Pokemon] = response.results.compactMap { Pokemon($0) }
            
            for item in items {
                try? await persistenceUtility.insert(item)
            }
            
            return items
        } catch {
            do {
                return try await persistenceUtility.fetchPokemons()
            } catch {
                return []
            }
        }
    }
}
