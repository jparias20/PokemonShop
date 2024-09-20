import CoreData
import Foundation

final class CoreDataProvider: PersistenceUtility {
    static let shared = CoreDataProvider()
    
    func fetchPokemons() async throws -> [Pokemon] {
        []
    }
    
    func insert(_ item: Pokemon) async throws {}
}
