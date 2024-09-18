import SwiftUI

struct HomeView: View {
    @StateObject var pokemonService = PokemonService()
    
    @State private var pokemons: [Pokemon] = []
    @State private var isLoading: Bool = false
        
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(pokemons) { item in
                        PokemonView(pokemon: item)
                            .environmentObject(pokemonService)
                    }
                }
            }
            .navigationTitle("Home")
            .toolbarTitleDisplayMode(.inline)
            .loadingView(isPresented: $isLoading)
            .onAppear { fetchPokemons() }
        }
    }
    
    private func fetchPokemons() {
        Task { @MainActor in
            isLoading = true
            pokemons = await pokemonService.fetchPokemons()
            isLoading = false
        }
    }
}

private struct PokemonView: View {
    private var size: CGFloat { 120 }
    
    @ObservedObject var pokemon: Pokemon
    @EnvironmentObject private var pokemonService: PokemonService
    @EnvironmentObject private var imageService: ImageService
    
    @State private var image: Image?
    
    @ViewBuilder private var imageView: some View {
        VStack {
            if let image {
                image
            } else {
                ProgressView()
                    .frame(width: size, height: size)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray.opacity(0.1))
        }
        .padding()
    }
    
    var body: some View {
        HStack {
            imageView
            
            Text(pokemon.nameFormatted)
                .bold()
            
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .shadow(color: .gray.opacity(0.5), radius: 2, x: 1, y: 1)
        }
        .padding(.horizontal)
        .padding(.bottom)
        .onAppear { fetchImage() }
    }
    
    private func fetchImage() {
        Task { @MainActor in
            do {
                guard let uiImage = try await pokemon.fetchImage(service: imageService) else {
                    setErrorImage()
                    return
                }
                self.image = Image(uiImage: uiImage)
            } catch {
                setErrorImage()
            }
        }
    }
    
    private func setErrorImage() {
        image = Image(systemName: "exclamationmark.triangle")
    }
}

#Preview {
    HomeView()
}
