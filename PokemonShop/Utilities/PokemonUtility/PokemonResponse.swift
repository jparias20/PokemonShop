import Foundation

struct PokemonFetchResponse: Decodable {
    let results: [PokemonResponse]
}

struct PokemonResponse: Decodable {
    let name: String
    let url: String
}
