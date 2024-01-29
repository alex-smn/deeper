//
//  PokemonModel.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation
import SwiftyJSON

class PokemonModel: Identifiable, ObservableObject {
    var id: Int { entryNumber }
    var entryNumber: Int
    var name: String
    var infoUrl: String
    @Published var details: PokemonDetailsModel?
    
    init(entryNumber: Int, name: String, infoUrl: String, details: PokemonDetailsModel?) {
        self.entryNumber = entryNumber
        self.name = name
        self.infoUrl = infoUrl
        self.details = details
    }
    
    init(_ json: JSON) {
        self.entryNumber = json["entry_number"].intValue
        self.name = json["pokemon_species"]["name"].stringValue
        self.infoUrl = json["pokemon_species"]["url"].stringValue
    }
}
