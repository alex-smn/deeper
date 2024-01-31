//
//  PokedexEntryView.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import SwiftUI
import Kingfisher

struct PokedexEntryView: View {
    var item: PokedexItem
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if let path = item.imageUrl,
                   let url = URL(string: path) {
                    KFImage(url)
                }

                Text(item.name)
                Text(String(item.entryNumber))
            }
        }
    }
}

struct PokemonListEntryView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexEntryView(item: PokedexItem(entryNumber: 1, imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", name: "Bulbasaur", isModelFull: true))
    }
}
