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
        let container = NSPersistentContainer(name: "MyPokemon")
        container.loadPersistentStores { (storeDescription, error) in
            if let error {
                print(error)
            }
        }
        
        let myPokemonData = MyPokemonData(context: container.viewContext)
        
        myPokemonData.number = Int32(pokemon.entryNumber)
        myPokemonData.name = pokemon.name
        myPokemonData.nickname = nickname
        myPokemonData.imageUrl = (pokemon.details?.imageUrl).flatMap { URL(string: $0) }
        
        do {
            try container.viewContext.save()
            print("saved pokemon with id: \(pokemon.entryNumber), nickname: \(nickname)")
        } catch {
            container.viewContext.rollback()
            print(error)
        }
    }
}
