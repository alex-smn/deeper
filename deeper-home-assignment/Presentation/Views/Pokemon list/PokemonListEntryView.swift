//
//  PokemonListEntryView.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import SwiftUI
import Kingfisher

struct PokemonListEntryView: View {
    @ObservedObject var model: PokemonModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if let path = model.details?.imageUrl,
                   let url = URL(string: path) {
                    KFImage(url)
                } else {
                    RoundedRectangle(cornerRadius: 12).foregroundColor(.gray)
                }

                Text(model.name)
                if let nickname = model.nickname {
                    Text(nickname)
                }
                Text(String(model.entryNumber))
            }
        }
    }
}

struct PokemonListEntryView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListEntryView(model: PokemonModel(entryNumber: 1, name: "Bulbasaur", infoUrl: "", details: nil, nickname: nil))
    }
}
