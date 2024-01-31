//
//  NetworkModels.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//

import Foundation

struct PokedexEntryNetworkModel: Codable {
    let entryNumber: Int
    let pokemonSpecies: PokemonSpeciesNetworkModel
}

struct PokemonSpeciesNetworkModel: Codable {
    let name: String
    let url: String
}

struct PokemonListResponse: Codable {
    let pokemonEntries: [PokedexEntryNetworkModel]
}

struct PokemonDetailsNetworkModel: Codable {
    let abilities: [PokemonAbilityNetworkModel]
    let height: Int
    let id: Int
    let moves: [PokemonMoveNetworkModel]
    let name: String
    let sprites: PokemonSpritesNetworkModel
    let stats: [PokemonStatNetworkModel]
    let weight: Int
}

struct PokemonAbilityNetworkModel: Codable {
    let ability: PokemonAbilityDetailsNetworkModel
    
    struct PokemonAbilityDetailsNetworkModel: Codable {
        let name: String
        let url: String
    }
}

struct PokemonMoveNetworkModel: Codable {
    let move: PokemonMoveDetailsNetworkModel
    
    struct PokemonMoveDetailsNetworkModel: Codable {
        let name: String
    }
}

struct PokemonSpritesNetworkModel: Codable {
    let backDefault: String
    let backShiny: String
    let frontDefault: String
    let frontShiny: String
}


struct PokemonStatNetworkModel: Codable {
    let baseStat: Int
    let stat: PokemonStatDetailsNetworkModel

    struct PokemonStatDetailsNetworkModel: Codable {
        let name: String
    }
}
