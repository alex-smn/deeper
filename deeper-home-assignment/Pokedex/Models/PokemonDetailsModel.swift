//
//  PokemonDetailsModel.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import Foundation
import SwiftyJSON

struct PokemonDetailsModel {
    var imageUrl: String
    var abilities: [String]
    var moves: [String]
    var height: Int
    
    init(imageUrl: String, abilities: [String], moves: [String], height: Int) {
        self.imageUrl = imageUrl
        self.abilities = abilities
        self.moves = moves
        self.height = height
    }
    
    init(_ json: JSON) {
        self.imageUrl = json["sprites"]["front_default"].stringValue
        self.abilities = json["abilities"].array?.map { $0["ability"]["name"].stringValue } ?? []
        self.moves = json["moves"].array?.map { $0["move"]["name"].stringValue } ?? []
        self.height = json["height"].intValue
    }
}
