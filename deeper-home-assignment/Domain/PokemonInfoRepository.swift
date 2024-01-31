//
//  PokemonInfoRepository.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 31/01/2024.
//

import Foundation

class PokemonInfoRepository {
    private let localDataSource = MyPokemonLocalDataSource()
    private let detailsNetworkDataSource = PokemonDetailsNetworkDataSource()

    func loadDetails(for pokemonEntryNumber: Int) async throws -> PokemonDetails {
        do {
            let networkResult = try await detailsNetworkDataSource.loadPokemonDetails(for: pokemonEntryNumber)
            return PokemonDetails.fromPokemonDetailsNetworkModel(model: networkResult)
        } catch {
            throw error
        }
    }
    
    
    func savePokemon(entryNumber: Int, nickname: String = "") {
        localDataSource.savePokemon(entryNumber: entryNumber, nickname: nickname)
    }
}
