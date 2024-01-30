//
//  PokemonData+CoreDataProperties.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//
//

import Foundation
import CoreData

extension PokemonData {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonData> {
        return NSFetchRequest<PokemonData>(entityName: "PokemonData")
    }

    @NSManaged public var number: Int32
    @NSManaged public var name: String?
    @NSManaged public var nickname: String?
    @NSManaged public var isSaved: Bool
    @NSManaged public var infoUrl: URL?
}

extension PokemonData : Identifiable { }

extension PokemonData {
    func toPokemonModel() -> PokemonModel {
        PokemonModel(entryNumber: Int(number), name: name ?? "", infoUrl: infoUrl?.absoluteString ?? "", details: nil, nickname: nickname, isSaved: isSaved)
    }
}
