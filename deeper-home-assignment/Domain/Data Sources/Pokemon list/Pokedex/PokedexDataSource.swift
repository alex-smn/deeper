//
//  PokedexDataSource.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation
import SwiftyJSON

class PokedexDataSource: PokemonListDataSourceProtocol {
    func loadData() -> Result<PokemonListModel, Error> {
        guard let url = URL(string: Constants.pokedexUrl) else { return .failure(PokedexError.pokedexListNotFound) }
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSON(data: data)
            let model = PokemonListModel(json)
            
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
    
    func loadDetails(for pokemon: PokemonModel) -> Result<PokemonDetailsModel, Error> {
        guard
            let url = URL(string: Constants.pokemonUrlFormat + pokemon.name)
        else {
            return .failure(PokedexError.pokemonDetailsNotFound)
        }
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSON(data: data)
            let model = PokemonDetailsModel(json)
            
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
    
}
