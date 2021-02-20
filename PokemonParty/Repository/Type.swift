//
//  Type.swift
//  PokemonParty
//
//  Created by 能美龍星 on 2021/02/20.
//

import Foundation

struct Type:Identifiable, Hashable {
    var id = UUID()
    var typeName: String = ""
    var strongType: [String] = []
    var weakType: [String] = []
}

