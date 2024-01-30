//
//  PokemonListModel.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation
import SwiftyJSON

struct PokemonListModel {
    var pokemonEntries: [PokemonModel]
    
    init(pokemonEntries: [PokemonModel]) {
        self.pokemonEntries = pokemonEntries.sorted(by: { $0.entryNumber < $1.entryNumber })
    }
    
    init(_ json: JSON) {
        self.pokemonEntries = json["pokemon_entries"].array?.map { PokemonModel($0) } ?? []
    }
}
