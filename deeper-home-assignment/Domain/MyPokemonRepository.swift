//
//  MyPokemonRepository.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 31/01/2024.
//

import Foundation

class MyPokemonRepository {
    private let localDataSource = MyPokemonLocalDataSource()
    private let detailsNetworkDataSource = PokemonDetailsNetworkDataSource()

    func loadData() throws -> [MyPokemonItem] {
        do {
            let result = localDataSource.loadPokemonList()
            switch result {
            case .success(let data):
                return data.map { MyPokemonItem.fromLocalDataModel(data: $0) }
            case .failure(let error):
                throw error
            }
        } catch {
            throw error
        }
    }
    
    func loadFullMyPokemonData(for item: MyPokemonItem) async throws -> MyPokemonItem {
        do {
            let networkResult = try await detailsNetworkDataSource.loadPokemonDetails(for: item.entryNumber)
            return MyPokemonItem.fromPokemonDetailsNetworkModel(model: networkResult, item: item)
        } catch {
            throw error
        }
    }
}
