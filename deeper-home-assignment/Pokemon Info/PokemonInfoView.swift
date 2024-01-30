//
//  PokemonInfoView.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//

import SwiftUI
import Kingfisher

struct PokemonInfoView: View {
    @ObservedObject var model: PokemonModel

    var body: some View {
        ZStack {
            VStack {
                if let path = model.details?.imageUrl,
                   let url = URL(string: path) {
                    KFImage(url)
                } else {
                    RoundedRectangle(cornerRadius: 12).foregroundColor(.gray)
                }
            }
            VStack(alignment: .center) {
                Spacer()
                Text(model.name)
                    .font(.body)
                Text(String(model.entryNumber))
            }
        }
    }
}

struct PokemonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoView(model: PokemonModel(entryNumber: 1, name: "Bulbasaur", infoUrl: "", details: nil))
    }
}
