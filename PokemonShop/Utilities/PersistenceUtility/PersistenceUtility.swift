import Foundation

protocol PersistenceUtility {
    func fetchPokemons() async throws -> [Pokemon]
    func insert(_ item: Pokemon) async throws
}
