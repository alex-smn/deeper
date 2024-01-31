//
//  PokemonDetails.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 31/01/2024.
//

import Foundation

struct PokemonDetails {
    let abilities: [String]
    let height: Int
    let id: Int
    let moves: [String]
    let name: String
    let imageUrl: String
    let stats: [PokemonStatModel]
    let weight: Int
}

extension PokemonDetails {
    static func fromPokemonDetailsNetworkModel(model: PokemonDetailsNetworkModel) -> PokemonDetails {
        PokemonDetails(
            abilities: model.abilities.map { $0.ability.name },
            height: model.height,
            id: model.id,
            moves: model.moves.map { $0.move.name },
            name: model.name,
            imageUrl: model.sprites.frontDefault,
            stats: model.stats.map { PokemonStatModel.fromNetworkModel(model: $0) },
            weight: model.weight
        )
    }
}

struct PokemonStatModel: Codable {
    let baseStat: Int
    let name: String
    
    static func fromNetworkModel(model: PokemonStatNetworkModel) -> PokemonStatModel {
        PokemonStatModel(baseStat: model.baseStat, name: model.stat.name)
    }
}
