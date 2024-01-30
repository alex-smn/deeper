//
//  PokedexDataSource.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation
import SwiftyJSON
import CoreData

class PokedexDataSource: PokemonListDataSourceProtocol {
    private let loadQueue = DispatchQueue(label: "Load queue")
    
    func loadData(completion: @escaping (Result<PokemonListModel, Error>) -> Void) {
        loadQueue.async { [weak self] in
            guard let self else { return }
            let storageResult = self.loadDataFromStorage()
            let networkResult = self.loadDataFromNetwork()
            
            switch networkResult {
            case .success(let model):
                DispatchQueue.main.async {
                    completion(networkResult)
                }
                clearStorage()
                saveDataToStorage(model: model)
            case .failure:
                DispatchQueue.main.async {
                    completion(storageResult)
                }
            }
        }
    }
    
    private func loadDataFromNetwork() -> Result<PokemonListModel, Error> {
        guard let url = URL(string: Constants.pokedexUrl) else { return .failure(PokedexError.pokedexListNotFound) }
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSON(data: data)
            let model = PokemonListModel(json)
            
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
    
    private func loadDataFromStorage() -> Result<PokemonListModel, Error> {
        let container = NSPersistentContainer(name: "Pokemon")
        container.loadPersistentStores { (storeDescription, error) in
            if let error {
                print(error)
            }
        }
        
        do {
            let request = NSFetchRequest<PokemonData>(entityName: "PokemonData")
            request.predicate = NSPredicate(format: "isSaved == false")
            let items = try container.viewContext.fetch(request)
            
            let model = PokemonListModel(pokemonEntries: items.map { $0.toPokemonModel() })
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
    
    func saveDataToStorage(model: PokemonListModel) {
        let container = NSPersistentContainer(name: "Pokemon")
        container.loadPersistentStores { (storeDescription, error) in
            if let error {
                print(error)
            }
        }
        
        for entry in model.pokemonEntries {
            _ = entry.toCoreData(context: container.viewContext)
        }
        
        do {
            try container.viewContext.save()
        } catch {
            print(error)
        }
    }
    
    private func clearStorage() {
        let container = NSPersistentContainer(name: "Pokemon")
        container.loadPersistentStores { (storeDescription, error) in
            if let error {
                print(error)
            }
        }
        
        do {
            let request = NSFetchRequest<PokemonData>(entityName: "PokemonData")
            request.predicate = NSPredicate(format: "isSaved == false")
            let items = try container.viewContext.fetch(request)
            
            for item in items {
                container.viewContext.delete(item)
            }
            
            try container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadDetails(for pokemon: PokemonModel, completion: @escaping (Result<PokemonDetailsModel, Error>) -> Void) {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            let result = loadDetailsFromServer(for: pokemon)
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    private func loadDetailsFromServer(for pokemon: PokemonModel) -> Result<PokemonDetailsModel, Error> {
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
}
