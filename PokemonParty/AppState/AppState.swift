import SwiftUI

class AppState: ObservableObject {
    struct PokemonObject {
        var pokemons: [Pokemon] = []
        var weakTypes: [Type] = []
        var typeCompatibility:[Type] = []
    }
    
    @Published public var pokemonObject = PokemonObject()
}
