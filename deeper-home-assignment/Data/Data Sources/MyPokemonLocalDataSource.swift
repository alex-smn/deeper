//
//  MyPokemonLocalDataSource.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//

import Foundation
import CoreData

class MyPokemonLocalDataSource {
    func loadPokemonList() -> Result<[PokemonData], Error> {
        let container = NSPersistentContainer(name: "Pokemon")
        container.loadPersistentStores { (storeDescription, error) in
            if let error {
                print(error.localizedDescription)
            }
        }
        
        do {
            let request = NSFetchRequest<PokemonData>(entityName: "PokemonData")
            let items = try container.viewContext.fetch(request)
            
            return .success(items)
        } catch {
            return .failure(error)
        }
    }
    
    func savePokemon(entryNumber: Int, nickname: String = "") {
        let container = NSPersistentContainer(name: "Pokemon")
        container.loadPersistentStores { (storeDescription, error) in
            if let error {
                print(error.localizedDescription)
            }
        }
        
        let pokemonData = PokemonData(context: container.viewContext)
        pokemonData.nickname = nickname
        pokemonData.number = Int32(entryNumber)
        pokemonData.id = UUID()
        
        do {
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
            print(error.localizedDescription)
        }
    }
}
