import Foundation
import SwiftData

private typealias CurrentScheme = SchemaV1

final class SwiftDataImpl: Sendable {
    static let shared = SwiftDataImpl()

    private let modelContainer: ModelContainer
    @MainActor private var context: ModelContext { modelContainer.mainContext }

    private init() {
        let schema = Schema(CurrentScheme.models)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    @MainActor private func fetch<T: PersistentModel>(_ fetchDescriptior: FetchDescriptor<T>) async throws -> [T] {
        try context.fetch(fetchDescriptior)
    }

    @MainActor private func insert(_ model: any PersistentModel) async throws {
        context.insert(model)
        try context.save()
    }
}

extension SwiftDataImpl: PersistenceUtility {
    func fetchPokemons() async throws -> [Pokemon] {
        let fetchDescriptior = FetchDescriptor<PokemonModel>()
        let response = try await fetch(fetchDescriptior)
        debugPrint("[🔥] - retriving from SwiftData", response.count)
        return response.map { Pokemon($0) }
    }
    
    func insert(_ item: Pokemon) async throws {
        let model = PokemonModel(
            id: item.id,
            name: item.name
        )
        try await insert(model)
    }
}
