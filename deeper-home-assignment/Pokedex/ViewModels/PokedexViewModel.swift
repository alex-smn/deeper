//
//  PokedexViewModel.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation
import SwiftyJSON

class PokedexViewModel: ObservableObject {
    @Published var model: PokedexModel?
    
    init() {
        start()
    }
    
    func start() {
        refreshData()
    }
    
    func refreshData() {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            let result = self.loadData()
            DispatchQueue.main.async { [weak self] in
                self?.handleNewData(result)
            }
        }
    }
    
    private func loadData() -> Result<PokedexModel, Error> {
        guard let url = URL(string: Constants.pokedexUrl) else { return .failure(PokedexError.pokedexListNotFound) }
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSON(data: data)
            let model = PokedexModel(json)
            
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
    
    private func handleNewData(_ result: Result<PokedexModel, Error>) {
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
                let result = self.loadDetails(for: pokemon)
                DispatchQueue.main.async { [weak self] in
                    self?.handleNewDetailedData(result, for: pokemon)
                }
            }
        }
    }
    
    private func loadDetails(for pokemon: PokemonModel) -> Result<PokemonDetailsModel, Error> {
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
    
    private func handleNewDetailedData(_ result: Result<PokemonDetailsModel, Error>, for pokemon: PokemonModel) {
        switch result {
        case .success(let model):
            pokemon.details = model
        case .failure(let error):
            print(error.localizedDescription)
        }
        
    }
}
