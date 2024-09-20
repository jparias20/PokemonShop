import Foundation
import NetworkingFramework

struct PokemonImageHTTPRequest: HTTPRequest {
    let host: String = "raw.githubusercontent.com"
    let servicePath: String
    var method: RequestMethod = .get
}
