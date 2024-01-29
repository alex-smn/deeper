//
//  PokedexModel.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation
import SwiftyJSON

struct PokedexModel {
    var pokemonEntries: [PokemonModel]
    
    init(_ json: JSON) {
        self.pokemonEntries = json["pokemon_entries"].array?.map { PokemonModel($0) } ?? []
    }
}
