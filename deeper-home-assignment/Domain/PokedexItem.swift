//
//  PokedexItem.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//

import Foundation

struct PokedexItem {
    let entryNumber: Int
    var imageUrl: String?
    let name: String
    let isModelFull: Bool
}

extension PokedexItem: Identifiable {
    var id: String { "\(entryNumber) + \(isModelFull)" }
}

extension PokedexItem {
    static func fromPokedexEntryNetworkModel(model: PokedexEntryNetworkModel) -> PokedexItem {
        PokedexItem(entryNumber: model.entryNumber, imageUrl: nil, name: model.pokemonSpecies.name, isModelFull: false)
    }
    
    static func fromPokemonDetailsNetworkModel(model: PokemonDetailsNetworkModel) -> PokedexItem {
        PokedexItem(entryNumber: model.id, imageUrl: model.sprites.frontDefault, name: model.name, isModelFull: true)
    }
}
