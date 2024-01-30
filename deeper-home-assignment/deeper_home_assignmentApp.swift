//
//  deeper_home_assignmentApp.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 29/01/2024.
//

import SwiftUI

@main
struct deeper_home_assignmentApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                PokemonListView(viewModel: PokemonListViewModel(dataSource: PokedexDataSource()))
                    .tabItem {
                        Label("All", systemImage: "list.bullet")
                    }

                PokemonListView(viewModel: PokemonListViewModel(dataSource: MyPokemonDataSource())) 
                    .tabItem {
                        Label("Saved", systemImage: "bookmark.fill")
                    }
            }
        }
    }
}
