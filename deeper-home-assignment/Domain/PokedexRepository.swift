//
//  PokedexRepository.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation
import CoreData

class PokedexRepository {
    private let networkDataSource = PokedexNetworkDataSource()
    private let detailsNetworkDataSource = PokemonDetailsNetworkDataSource()
    
    func loadData() async throws -> [PokedexItem] {
        do {
            let networkResult = try await networkDataSource.loadPokemonList()
            return networkResult.map { PokedexItem.fromPokedexEntryNetworkModel(model: $0) }
        } catch {
            throw error
        }
    }
    
    func loadFullPokedexItem(for pokemonEntryNumber: Int) async throws -> PokedexItem {
        do {
            let networkResult = try await detailsNetworkDataSource.loadPokemonDetails(for: pokemonEntryNumber)
            return PokedexItem.fromPokemonDetailsNetworkModel(model: networkResult)
        } catch {
            throw error
        }
    }
   
}
