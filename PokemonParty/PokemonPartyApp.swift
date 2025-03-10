//
//  PokemonPartyApp.swift
//  PokemonParty
//
//  Created by 能美龍星 on 2021/02/20.
//

import SwiftUI

@main
struct PokemonPartyApp: App {
    
    let appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(appState)
        }
    }
}
