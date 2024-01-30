//
//  PokemonListViewModel.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation
import SwiftyJSON

class PokemonListViewModel: ObservableObject {
    @Published var model: PokemonListModel?
    private let dataSource: PokemonListDataSource
    
    init(dataSource: PokemonListDataSource) {
        self.dataSource = dataSource
        start()
    }
    
    func start() {
        refreshData()
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
            self.loadDetailedData()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    private func loadDetailedData() {
        DispatchQueue.global().async { [weak self] in
            guard let self, let model = self.model else { return }
            for pokemon in model.pokemonEntries {
                guard pokemon.details == nil else { continue }
                let result = self.dataSource.loadDetails(for: pokemon)
                DispatchQueue.main.async { [weak self] in
                    self?.handleNewDetailedData(result, for: pokemon)
                }
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
