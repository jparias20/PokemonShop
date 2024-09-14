import Foundation
import NetworkingFramework

final class PokemonUtilityImpl {
    private let limit: Int
    private let httpClient: HTTPClient
    private var offset: Int
    
    init(httpClient: HTTPClient = HTTPClientImpl()) {
        self.offset = 0
        self.limit = 20
        self.httpClient = httpClient
    }
}

extension PokemonUtilityImpl: PokemonUtility {    
    func fetchPokemons() async throws -> [PokemonResponse] {
        do {
            let overrideDefaultHeaders = ["offset": "\(offset)", "limit": "\(limit)"]
            let request = PokemonHTTPRequest(servicePath: "/api/v2/pokemon", overrideDefaultHeaders: overrideDefaultHeaders)
            let response: PokemonFetchResponse = try await httpClient.sendRequest(request: request)
            offset += limit
            return response.results
        } catch {
           throw error
        }
    }
}
