//
//  PokedexView.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import SwiftUI

struct PokedexView: View {
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let height: CGFloat = 150
    
    @ObservedObject var viewModel: PokedexViewModel
    @State private var selectedEntry: PokedexItem?
    @State private var isLinkActive = false

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.pokemonList) { entry in
                        Button(action: {
                            self.selectedEntry = entry
                            self.isLinkActive = true
                        }) {
                            PokedexEntryView(item: entry)
                                .frame(height: height)
                                .onAppear { viewModel.pokemonEntryAppeared(entry) }
                        }
                        .foregroundColor(.black)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .toolbarBackground(Color.white, for: .tabBar)
            .background(
                NavigationLink(
                    destination: Group {
                        if let selectedEntry = selectedEntry {
                            PokemonInfoView(viewModel: PokemonInfoViewModel(selectedEntry.entryNumber))
                        }
                    },
                    isActive: $isLinkActive,
                    label: { EmptyView() }
                ).hidden()
            )
        }
        .onAppear {
            viewModel.refreshData()
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView(viewModel: PokedexViewModel(repository: PokedexRepository()))
    }
}

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
