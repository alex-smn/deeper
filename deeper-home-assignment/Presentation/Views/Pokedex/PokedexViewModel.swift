//
//  PokedexViewModel.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation

class PokedexViewModel: ObservableObject {
    @Published var pokemonList = [PokedexItem]()
    private let repository: PokedexRepository
    
    init(repository: PokedexRepository) {
        self.repository = repository
    }
    
    func refreshData() {
        Task { [weak self] in
            guard let self else { return }
            
            do {
                let result = try await self.repository.loadData()
                await self.handleNewData(result)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    private func handleNewData(_ items: [PokedexItem]) {
        self.pokemonList = items
    }
    
    func pokemonEntryAppeared(_ pokemon: PokedexItem) {
        loadDetailedData(for: pokemon)
    }
    
    private func loadDetailedData(for pokemon: PokedexItem) {
        guard !pokemon.isModelFull else { return }
        
        Task { [weak self] in
            guard let self else { return }
            do {
                let result = try await self.repository.loadFullPokedexItem(for: pokemon.entryNumber)
                await self.handleNewDetailedData(result, entryNumber: pokemon.entryNumber)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    private func handleNewDetailedData(_ item: PokedexItem, entryNumber: Int) {
        pokemonList = pokemonList.map {
            var result = $0
            if $0.entryNumber == entryNumber {
                result = item
            }
            return result
        }
    }
}
