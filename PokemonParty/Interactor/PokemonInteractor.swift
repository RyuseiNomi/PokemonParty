
import Foundation

class PokemonInteractor {
    
    public var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    // 入力されたポケモンを受け取り、AppStateに追加
    public func addPokemon(_ name: String) {
        var pokemon = Pokemon()
        pokemon.name = name
        self.appState.pokemonObject.pokemons.append(pokemon)
    }
    
    public func deletePokemon(_ name: String) {
        guard let deletePokemonIndex = self.appState.pokemonObject.pokemons.index(where: { $0.name == name}) else {
            return
        }
        self.appState.pokemonObject.pokemons.remove(at: deletePokemonIndex)
    }
    
    // 苦手タイプを導き出す
    public func deriveWeakType() {
        
    }
}
