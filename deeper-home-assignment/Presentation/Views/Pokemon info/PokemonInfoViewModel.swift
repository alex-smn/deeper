//
//  PokemonInfoViewModel.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//

import Foundation

class PokemonInfoViewModel {
    let model: PokemonModel
    let dataSource: PokemonInfoDataSource
    
    init(model: PokemonModel, dataSource: PokemonInfoDataSource) {
        self.model = model
        self.dataSource = dataSource
    }
    
    func savePokemon(_ pokemon: PokemonModel, nickname: String = "") {
        dataSource.save(pokemon: pokemon, nickname: nickname)
    }
}
