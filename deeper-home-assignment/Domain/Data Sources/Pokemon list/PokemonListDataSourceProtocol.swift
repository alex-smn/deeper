//
//  PokemonListDataSourceProtocol.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation

protocol PokemonListDataSourceProtocol {
    func loadData(completion: @escaping (Result<PokemonListModel, Error>) -> Void)
    func loadDetails(for pokemon: PokemonModel, completion: @escaping (Result<PokemonDetailsModel, Error>) -> Void)
}
