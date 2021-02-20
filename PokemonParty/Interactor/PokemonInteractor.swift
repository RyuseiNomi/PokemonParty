
import Foundation
import PokemonAPI

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
        self.deriveWeakType(name)
    }
    
    public func deletePokemon(_ name: String) {
        guard let deletePokemonIndex = self.appState.pokemonObject.pokemons.index(where: { $0.name == name}) else {
            return
        }
        self.appState.pokemonObject.pokemons.remove(at: deletePokemonIndex)
    }
    
    // 苦手タイプを導き出す
    public func deriveWeakType(_ name: String) {
        let types = self.fetchPokemonType(name)
        dump(types)
    }
    
    private func fetchPokemonType(_ name: String) -> [PKMPokemonType] {
        var types: [PKMPokemonType] = []
        PokemonAPI().pokemonService.fetchPokemon(name) { result in
            switch result {
            case .success(let pokemon):
                types = pokemon.types!
            case .failure(let error):
                print(error)
            }
        }
        return types
    }
}
