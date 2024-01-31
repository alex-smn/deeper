//
//  MyPokemonItem.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 31/01/2024.
//

import Foundation

struct MyPokemonItem {
    let uuid: UUID
    let entryNumber: Int
    let imageUrl: String?
    let name: String?
    let nickname: String?
    let isModelFull: Bool
}

extension MyPokemonItem: Identifiable {
    var id: String { "\(uuid) + \(isModelFull)" }
}

extension MyPokemonItem {
    static func fromLocalDataModel(data: PokemonData) -> MyPokemonItem {
        MyPokemonItem(uuid: data.id, entryNumber: Int(data.number), imageUrl: nil, name: nil, nickname: data.nickname, isModelFull: false)
    }
    
    static func fromPokemonDetailsNetworkModel(model: PokemonDetailsNetworkModel, item: MyPokemonItem) -> MyPokemonItem {
        MyPokemonItem(uuid: item.uuid, entryNumber: model.id, imageUrl: model.sprites.frontDefault, name: model.name, nickname: item.nickname, isModelFull: true)
    }
}
