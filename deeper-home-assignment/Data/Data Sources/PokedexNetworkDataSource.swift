//
//  PokedexNetworkDataSource.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//

import Foundation

class PokedexNetworkDataSource {
    func loadPokemonList() async throws -> [PokedexEntryNetworkModel] {
        guard let url = URL(string: Constants.pokedexUrl) else { throw PokedexError.pokedexListNotFound }
        
        let response: PokemonListResponse = try await NetworkHelper.performNetworkRequest(url: url, responseType: PokemonListResponse.self)
        return response.pokemonEntries
    }
}
