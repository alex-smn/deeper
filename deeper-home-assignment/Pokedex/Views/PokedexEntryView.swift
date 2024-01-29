//
//  CellView.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import SwiftUI

struct PokedexEntryView: View {
    @ObservedObject var model: PokemonModel
    
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 12).foregroundColor(.random)
            }
            VStack(alignment: .center) {
                Spacer()
                Text(model.name)
                    .font(.body)
                Text(String(model.entryNumber))
                Text(String(model.details?.height ?? 0))
            }
        }
    }
}

struct PokedexEntryView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexEntryView(model: PokemonModel(entryNumber: 1, name: "Bulbasaur", infoUrl: "", details: nil))
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
