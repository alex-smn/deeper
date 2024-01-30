//
//  PokemonListDataSourceProtocol.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation

protocol PokemonListDataSourceProtocol {
    func loadData() -> Result<PokemonListModel, Error>
    func loadDetails(for pokemon: PokemonModel) -> Result<PokemonDetailsModel, Error>
}
