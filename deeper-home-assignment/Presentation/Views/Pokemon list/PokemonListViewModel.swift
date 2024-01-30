//
//  PokemonListViewModel.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation
import SwiftUI
import SwiftyJSON

class PokemonListViewModel: ObservableObject {
    @Published var model: PokemonListModel?
    private let dataSource: PokemonListDataSourceProtocol
    
    init(dataSource: PokemonListDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func showPokemonInfo(for pokemon: PokemonModel) -> some View {
        PokemonInfoView(viewModel: PokemonInfoViewModel(model: pokemon, dataSource: PokemonInfoDataSource()))
    }
    
    func refreshData() {
        dataSource.loadData(completion: { [weak self] result in
            self?.handleNewData(result)
        })
    }
    
    private func handleNewData(_ result: Result<PokemonListModel, Error>) {
        switch result {
        case .success(let model):
            for pokemon in model.pokemonEntries {
                pokemon.details = self.model?.pokemonEntries.first(where: { $0.entryNumber == pokemon.entryNumber })?.details
            }
            self.model = model
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func pokemonEntryAppeared(_ pokemon: PokemonModel) {
        loadDetailedData(pokemon)
    }
    
    private func loadDetailedData(_ pokemon: PokemonModel) {
        guard pokemon.details == nil else { return }

        dataSource.loadDetails(for: pokemon, completion: { [weak self] result in
            self?.handleNewDetailedData(result, for: pokemon)
        })
    }
    
    private func handleNewDetailedData(_ result: Result<PokemonDetailsModel, Error>, for pokemon: PokemonModel) {
        switch result {
        case .success(let model):
            if let pokemonEntries = self.model?.pokemonEntries {
                for pokemon in pokemonEntries.filter({ $0.entryNumber == pokemon.entryNumber }) {
                    pokemon.details = model
                }
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
        
    }
}
