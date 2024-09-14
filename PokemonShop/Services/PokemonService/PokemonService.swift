import Foundation
import UIKit

final class PokemonService: ObservableObject {
    private let pokemonUtility: PokemonUtility
    
    init(pokemonUtility: PokemonUtility = PokemonUtilityImpl()) {
        self.pokemonUtility = pokemonUtility
    }
    
    func fetchPokemons() async throws -> [Pokemon] {
        do {
            let response: [PokemonResponse] = try await pokemonUtility.fetchPokemons()
            return response.compactMap { Pokemon($0) }
        } catch {
           throw error
        }
    }
}
