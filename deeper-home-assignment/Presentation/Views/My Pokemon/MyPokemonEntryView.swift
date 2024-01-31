//
//  MyPokemonEntryView.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 31/01/2024.
//

import SwiftUI
import Kingfisher

struct MyPokemonEntryView: View {
    var item: MyPokemonItem
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if let path = item.imageUrl,
                   let url = URL(string: path) {
                    KFImage(url)
                }

                if let name = item.name {
                    Text(name)
                }
                if let nickname = item.nickname {
                    Text(nickname)
                }
                Text(String(item.entryNumber))
            }
        }
    }
}

struct MyPokemonEntryView_Previews: PreviewProvider {
    static var previews: some View {
        MyPokemonEntryView(item: MyPokemonItem(uuid: UUID(), entryNumber: 1, imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", name: "Bulbasaur", nickname: "Bulba", isModelFull: true))
    }
}
