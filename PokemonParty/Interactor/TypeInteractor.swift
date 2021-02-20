//
//  TypeInteractor.swift
//  PokemonParty
//
//  Created by 能美龍星 on 2021/02/20.
//

import Foundation
import PokemonAPI
import Combine

class TypeInteractor: ObservableObject {
    
    public var appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }
    
    // タイプ相性の設定
    public func setTypeCompatibility() {
        // ノーマル
        var normal = Type()
        normal.typeName = "normal"
        normal.strongType = []
        normal.weakType = ["fighting"]
        self.appState.pokemonObject.typeCompatibility.append(normal)
        // ほのお
        var fire = Type()
        fire.typeName = "fire"
        fire.strongType = ["grass", "ice", "bug", "steel"]
        fire.weakType = ["water", "ground", "rock"]
        self.appState.pokemonObject.typeCompatibility.append(fire)
        // みず
        var water = Type()
        water.typeName = "water"
        water.strongType = ["fire", "ground", "rock"]
        water.weakType = ["electric", "grass"]
        self.appState.pokemonObject.typeCompatibility.append(water)
        // くさ
        var grass = Type()
        grass.typeName = "grass"
        grass.strongType = ["water", "ground", "rock"]
        grass.weakType = ["fire", "ice", "poison", "flying", "bug"]
        self.appState.pokemonObject.typeCompatibility.append(grass)
        // かくとう
        var fighting = Type()
        fighting.typeName = "fighting"
        fighting.strongType = ["normal", "ice", "rock"]
        fighting.weakType = ["flying", "psychic", "fairy"]
        self.appState.pokemonObject.typeCompatibility.append(fighting)
    }

    public func updateWeakType(_ name: String) {
        var types: [PKMPokemonType] = []
        PokemonAPI().pokemonService.fetchPokemon(name) { result in
            switch result {
            case .success(let pokemon):
                dump("a")
                types = pokemon.types!
                for type in types {
                    let typeName = type.type!.name!
                    self.findWeakType(typeName)
                }
            case .failure(let error):
                print(error)
            }
        }
        //let publisher = Future<String, Error> { promise in
        //    promise(.success("OK"))
        //}
        //let cancellable = PokemonAPI().pokemonService.fetchPokemon(name)
        //    .sink(receiveCompletion: { completion in
        //        if case .failure(let error) = completion {
        //            print(error.localizedDescription)
        //        }
        //    }, receiveValue: { pokemon in
        //        types = pokemon.types!
        //        for type in types {
        //            let typeName = type.type!.name!
        //            self.findWeakType(typeName)
        //        }
        //    })
    }
    
    private func findWeakType(_ typeName: String) {
        guard let type = self.appState.pokemonObject.typeCompatibility.first(where: { $0.typeName == typeName }) else {
            return
        }
        // 得意タイプより、既に定義されている苦手タイプの消去
        //if self.appState.pokemonObject.weakTypes != [] {
        //    for weakType in self.appState.pokemonObject.weakTypes {
        //        if weakType.typeName == type.strongType {
        //            self.removeWeakType(typeName)
        //        }
        //    }
        //}
        // 苦手タイプの追加
        for weakType in type.weakType {
            guard let weakTypeObject = self.appState.pokemonObject.typeCompatibility.first(where: { $0.typeName == weakType }) else {
                return
            }
            self.appState.pokemonObject.weakTypes.append(weakTypeObject)
        }
    }
    
    //private func removeWeakType(_ typeName: String) {
    //    guard let deleteTypeIndex = self.appState.pokemonObject.weakTypes.index(where: { $0.typeName == typeName }) else {
    //        return
    //    }
    //    self.appState.pokemonObject.weakTypes.remove(at: deleteTypeIndex)
    //}
}
