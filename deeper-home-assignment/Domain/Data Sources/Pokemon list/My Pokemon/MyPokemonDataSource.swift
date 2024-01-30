//
//  MyPokemonDataSource.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//

import Foundation
import SwiftyJSON
import CoreData

class MyPokemonDataSource: PokemonListDataSourceProtocol { // TODO: change data sources
    func loadData() -> Result<PokemonListModel, Error> {
        let container = NSPersistentContainer(name: "MyPokemon")
        container.loadPersistentStores { (storeDescription, error) in
            if let error {
                print(error)
            }
        }
        
        do {
            let request = NSFetchRequest<MyPokemonData>(entityName: "MyPokemonData")
            let items = try container.viewContext.fetch(request)
            
            let model = PokemonListModel(pokemonEntries: items.map {
                PokemonModel(entryNumber: Int($0.number), name: $0.name ?? "", infoUrl: "", details: PokemonDetailsModel(imageUrl: $0.imageUrl?.absoluteString ?? ""))
            })
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
    
    func loadDetails(for pokemon: PokemonModel) -> Result<PokemonDetailsModel, Error> {
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
