//
//  MyPokemonData+CoreDataProperties.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//
//

import Foundation
import CoreData


extension MyPokemonData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyPokemonData> {
        return NSFetchRequest<MyPokemonData>(entityName: "MyPokemonData")
    }

    @NSManaged public var number: Int32
    @NSManaged public var name: String?
    @NSManaged public var nickname: String?
    @NSManaged public var imageUrl: URL?

}

extension MyPokemonData : Identifiable {

}
