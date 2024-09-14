import Foundation

protocol PokemonUtility {
    func fetchPokemons() async throws -> [PokemonResponse]
}
