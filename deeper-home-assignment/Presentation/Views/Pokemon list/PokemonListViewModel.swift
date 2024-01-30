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
        start()
    }
    
    func start() {
        refreshData()
    }
    
    func showPokemonInfo(for pokemon: PokemonModel) -> some View {
        PokemonInfoView(viewModel: PokemonInfoViewModel(model: pokemon, dataSource: PokemonInfoDataSource()))
    }
    
    func refreshData() {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            let result = self.dataSource.loadData()
            DispatchQueue.main.async { [weak self] in
                self?.handleNewData(result)
            }
        }
    }
    
    private func handleNewData(_ result: Result<PokemonListModel, Error>) {
        switch result {
        case .success(let model):
            self.model = model
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func pokemonEntryAppeared(_ pokemon: PokemonModel) {
        loadDetailedData(pokemon)
    }
    
    private func loadDetailedData(_ pokemon: PokemonModel) {
        DispatchQueue.global().async { [weak self] in
            guard
                let self,
                pokemon.details == nil
            else {
                return
            }

            let result = self.dataSource.loadDetails(for: pokemon)
            DispatchQueue.main.async { [weak self] in
                self?.handleNewDetailedData(result, for: pokemon)
            }
        }
    }
    
    private func handleNewDetailedData(_ result: Result<PokemonDetailsModel, Error>, for pokemon: PokemonModel) {
        switch result {
        case .success(let model):
            pokemon.details = model
        case .failure(let error):
            print(error.localizedDescription)
        }
        
    }
}
