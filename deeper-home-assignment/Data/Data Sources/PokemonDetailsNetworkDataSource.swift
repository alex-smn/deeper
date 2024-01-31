//
//  PokemonDetailsNetworkDataSource.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 31/01/2024.
//

import Foundation

class PokemonDetailsNetworkDataSource {
    func loadPokemonDetails(for pokemonEntryNumber: Int) async throws -> PokemonDetailsNetworkModel {
        guard
            let url = URL(string: Constants.pokemonUrlFormat + String(pokemonEntryNumber))
        else {
            throw PokedexError.pokemonDetailsNotFound
        }
        
        let response: PokemonDetailsNetworkModel = try await NetworkHelper.performNetworkRequest(url: url, responseType: PokemonDetailsNetworkModel.self)
        return response
    }
}
