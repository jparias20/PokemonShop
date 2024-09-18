import Foundation
import UIKit

final class PokemonService: ObservableObject {
    private let pokemonUtility: PokemonUtility
    private let persistenceUtility: PersistenceUtility
    
    init(
        pokemonUtility: PokemonUtility = PokemonUtilityImpl(),
        persistenceUtility: PersistenceUtility = SwiftDataImpl.shared
    ) {
        self.pokemonUtility = pokemonUtility
        self.persistenceUtility = persistenceUtility
    }
    
    func fetchPokemons() async -> [Pokemon] {
        do {
            let response: [PokemonResponse] = try await pokemonUtility.fetchPokemons()
            let items: [Pokemon] = response.compactMap { Pokemon($0) }
            
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
