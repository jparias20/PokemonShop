import Foundation
import NetworkingFramework

struct PokemonHTTPRequest: HTTPRequest {
    let host: String = "pokeapi.co"
    let servicePath: String
    var method: RequestMethod = .get
    var overrideDefaultHeaders: [String: String]?
}
