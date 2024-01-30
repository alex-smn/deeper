//
//  PokemonInfoDataSourceProtocol.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//

import Foundation

protocol PokemonInfoDataSourceProtocol {
    func save(pokemon: PokemonModel, nickname: String)
}
