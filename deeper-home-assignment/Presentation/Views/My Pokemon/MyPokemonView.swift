//
//  MyPokemonView.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import SwiftUI

struct MyPokemonView: View {
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let height: CGFloat = 150
    
    @State var counter: Int = 0
    
    @ObservedObject var viewModel: MyPokemonViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.pokemonList) { entry in
                    MyPokemonEntryView(item: entry)
                        .frame(height: height)
                        .onAppear { viewModel.pokemonEntryAppeared(entry) }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.refreshData()
        }
    }
}

struct MyPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        MyPokemonView(viewModel: MyPokemonViewModel(repository: MyPokemonRepository()))
    }
}
