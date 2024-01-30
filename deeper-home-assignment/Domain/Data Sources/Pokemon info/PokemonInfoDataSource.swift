//
//  PokemonInfoDataSource.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//

import Foundation
import CoreData

class PokemonInfoDataSource: PokemonInfoDataSourceProtocol {
    func save(pokemon: PokemonModel, nickname: String = "") {
        let container = NSPersistentContainer(name: "Pokemon")
        container.loadPersistentStores { (storeDescription, error) in
            if let error {
                print(error)
            }
        }
        
        let pokemonData = pokemon.toCoreData(context: container.viewContext)
        pokemonData.nickname = nickname
        pokemonData.isSaved = true
        
        do {
            try container.viewContext.save()
            print("saved pokemon with id: \(pokemon.entryNumber), nickname: \(nickname)")
        } catch {
            container.viewContext.rollback()
            print(error)
        }
    }
}
