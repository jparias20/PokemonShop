import SwiftUI

struct HomeView: View {
    @StateObject var pokemonService = PokemonService()
    
    @State private var pokemons: [Pokemon] = []
    @State private var isLoading: Bool = false
    
    var body: some View {
        List(pokemons) { item in
            PokemonView(pokemon: item)
                .environmentObject(pokemonService)
        }
        .loadingView(isPresented: $isLoading)
        .onAppear { fetchPokemons() }
    }
        
    private func fetchPokemons() {
        Task { @MainActor in
            defer {
                isLoading = false
            }
            
            do {
                isLoading = true
                pokemons = try await pokemonService.fetchPokemons()
            } catch {
              print("Error", error)
            }
        }
    }
}

private struct PokemonView: View {
    @ObservedObject var pokemon: Pokemon
    @EnvironmentObject private var pokemonService: PokemonService
    @EnvironmentObject private var imageService: ImageService
    
    @State private var image: UIImage?

    var body: some View {
        HStack {
            Group {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 150, height: 150)
                } else {
                    ProgressView()
                        .frame(width: 150, height: 150)
                }
            }
            
            Text(pokemon.name)
        }
        .task { @MainActor in
            image = await pokemon.fetchImage(service: imageService)
        }
    }
}

#Preview {
    HomeView()
}
