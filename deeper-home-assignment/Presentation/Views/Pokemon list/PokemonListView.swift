//
//  PokemonListView.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import SwiftUI

struct PokemonListView: View {
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let height: CGFloat = 150
    
    @ObservedObject var viewModel: PokemonListViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.model?.pokemonEntries ?? []) { entry in
                        NavigationLink(
                            destination: { viewModel.showPokemonInfo(for: entry) },
                            label: {
                                PokedexEntryView(model: entry)
                                    .frame(height: height)
                                    .onAppear { viewModel.pokemonEntryAppeared(entry) }
                            }
                        )
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.refreshData()
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView(viewModel: PokemonListViewModel(dataSource: PokedexDataSource()))
    }
}
