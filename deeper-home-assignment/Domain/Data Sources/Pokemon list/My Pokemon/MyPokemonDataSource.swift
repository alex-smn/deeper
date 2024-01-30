//
//  MyPokemonDataSource.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//

import Foundation
import SwiftyJSON
import CoreData

class MyPokemonDataSource: PokemonListDataSourceProtocol {
    func loadData(completion: @escaping (Result<PokemonListModel, Error>) -> Void) {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            let result = self.loadDataFromStorage()
            
            DispatchQueue.main.async {
                completion(result)
            }
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
            request.predicate = NSPredicate(format: "isSaved == true")
            let items = try container.viewContext.fetch(request)
            
            let model = PokemonListModel(pokemonEntries: items.map { $0.toPokemonModel() })
            return .success(model)
        } catch {
            return .failure(error)
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
