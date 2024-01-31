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
                PokedexView(viewModel: PokedexViewModel(repository: PokedexRepository()))
                    .tabItem {
                        Label("All", systemImage: "bookmark.fill")
                    }

                MyPokemonView(viewModel: MyPokemonViewModel(repository: MyPokemonRepository()))
                    .tabItem {
                        Label("Saved", systemImage: "bookmark.fill")
                    }
            }
        }
    }
}
