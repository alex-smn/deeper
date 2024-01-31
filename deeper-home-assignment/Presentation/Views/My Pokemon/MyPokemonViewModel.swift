//
//  MyPokemonViewModel.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 31/01/2024.
//

import Foundation
import SwiftUI

class MyPokemonViewModel: ObservableObject {
    @Published var pokemonList = [MyPokemonItem]()
    private let repository: MyPokemonRepository
    
    init(repository: MyPokemonRepository) {
        self.repository = repository
    }
    
    func refreshData() {
        do {
            let result = try self.repository.loadData()
            self.pokemonList = result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func pokemonEntryAppeared(_ pokemon: MyPokemonItem) {
        loadDetailedData(for: pokemon)
    }
    
    private func loadDetailedData(for pokemon: MyPokemonItem) {
        guard !pokemon.isModelFull else { return }
        
        Task { [weak self] in
            guard let self else { return }
            do {
                let result = try await self.repository.loadFullMyPokemonData(for: pokemon)
                await self.handleNewDetailedData(result, uuid: pokemon.uuid)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    private func handleNewDetailedData(_ item: MyPokemonItem, uuid: UUID) {
        let pokemonList = pokemonList.map {
            var result = $0
            if $0.uuid == uuid {
                result = item
            }
            return result
        }
        self.pokemonList = pokemonList
    }
}
