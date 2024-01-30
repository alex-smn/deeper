//
//  PokemonModel.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation
import SwiftyJSON
import CoreData

class PokemonModel: Identifiable, ObservableObject {
    var id = UUID()
    var entryNumber: Int
    var name: String
    var infoUrl: String
    var nickname: String?
    var isSaved: Bool
    @Published var details: PokemonDetailsModel?
    
    init(entryNumber: Int, name: String, infoUrl: String, details: PokemonDetailsModel?, nickname: String?, isSaved: Bool = false) {
        self.entryNumber = entryNumber
        self.name = name
        self.infoUrl = infoUrl
        self.details = details
        self.nickname = nickname
        self.isSaved = isSaved
    }
    
    init(_ json: JSON) {
        self.entryNumber = json["entry_number"].intValue
        self.name = json["pokemon_species"]["name"].stringValue
        self.infoUrl = json["pokemon_species"]["url"].stringValue
        self.isSaved = false
    }
}

extension PokemonModel {
    func toCoreData(context: NSManagedObjectContext) -> PokemonData {
        let data = PokemonData(context: context)
        
        data.number = Int32(entryNumber)
        data.name = name
        data.nickname = nickname
        data.isSaved = isSaved
        
        return data
    }
}
