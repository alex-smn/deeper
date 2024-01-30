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
    var hp: Int
    var attack: Int
    var defense: Int
    var specialAttack: Int
    var specialDefense: Int
    var speed: Int
    
    init(
        imageUrl: String,
        abilities: [String] = [],
        moves: [String] = [],
        height: Int = 0,
        hp: Int = 0,
        attack: Int = 0,
        defense: Int = 0,
        specialAttack: Int = 0,
        specialDefense: Int = 0,
        speed: Int = 0
    ) {
        self.imageUrl = imageUrl
        self.abilities = abilities
        self.moves = moves
        self.height = height
        self.hp = hp
        self.attack = attack
        self.defense = defense
        self.specialAttack = specialAttack
        self.specialDefense = specialDefense
        self.speed = speed
    }
    
    init(_ json: JSON) {
        self.imageUrl = json["sprites"]["front_default"].stringValue
        self.abilities = json["abilities"].array?.map { $0["ability"]["name"].stringValue } ?? []
        self.moves = json["moves"].array?.map { $0["move"]["name"].stringValue } ?? []
        self.height = json["height"].intValue
        self.hp = json["stats"].array?.first(where: { $0["stat"]["name"] == "hp" })?["base_stat"].intValue ?? 0
        self.attack = json["stats"].array?.first(where: { $0["stat"]["name"] == "attack" })?["base_stat"].intValue ?? 0
        self.defense = json["stats"].array?.first(where: { $0["stat"]["name"] == "defense" })?["base_stat"].intValue ?? 0
        self.specialAttack = json["stats"].array?.first(where: { $0["stat"]["name"] == "special-attack" })?["base_stat"].intValue ?? 0
        self.specialDefense = json["stats"].array?.first(where: { $0["stat"]["name"] == "special-defense" })?["base_stat"].intValue ?? 0
        self.speed = json["stats"].array?.first(where: { $0["stat"]["name"] == "speed" })?["base_stat"].intValue ?? 0
    }
}
