import SwiftUI

class AppState: ObservableObject {
    struct PokemonObject {
        var pokemons: [Pokemon] = []
    }
    
    @Published public var pokemonObject = PokemonObject()
}
