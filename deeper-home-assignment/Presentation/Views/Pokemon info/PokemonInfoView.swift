//
//  PokemonInfoView.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//

import SwiftUI
import Kingfisher

struct PokemonInfoView: View {
    var viewModel: PokemonInfoViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        switch viewModel.state {
        case .completed(let details):
            InfoView(viewModel: viewModel, details: details)
        case .notInited, .loading:
            ProgressView()
        case .error:
            VStack {
                Text("ERROR")
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Text("OK")
                }
            }
        }
    }
}

private struct InfoView: View {
    var viewModel: PokemonInfoViewModel
    var details: PokemonDetails
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingSaveAlert = false
    @State private var showingIsSavedAlert = false
    @State private var nickname = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack {
                    Text(String(details.id))
                    Text(details.name.uppercased())
                }
                .font(.title2)
                .padding(.top, 30.0)
                
                Spacer()
                
                if let url = URL(string: details.imageUrl) {
                    KFImage(url)
                }
                
                Spacer()
                
                Text("Height: \(details.height)")
                
                HStack {
                    if let hp = details.stats.first(where: { $0.name == "HP" })?.baseStat {
                        Text("HP: \(hp)")
                    }
                    
                    if let attack = details.stats.first(where: { $0.name == "attack" })?.baseStat {
                        Text("Attack: \(attack)")
                    }
                    
                    if let defense = details.stats.first(where: { $0.name == "defense" })?.baseStat {
                        Text("Defense: \(defense)")
                    }
                    
                    if let speed = details.stats.first(where: { $0.name == "speed" })?.baseStat {
                        Text("Speed: \(speed)")
                    }
                }
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Abilities:")
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                        ForEach(details.abilities, id: \.self) { ability in
                            Text("- \(ability)")
                        }
                        .padding(.horizontal, 10)
                    }
                    .padding(.bottom, 10)
                    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    
                    
                    
                    Spacer()
                        .frame(width: 50)
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Moves:")
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                            ForEach(details.moves, id: \.self) { move in
                                Text("- \(move)")
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .frame(maxHeight: 200)
                    .padding(.bottom, 10)
                    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                }
                
                Spacer()
                
                Button("Add to my pokemons") {
                    showingSaveAlert.toggle()
                }
                .alert("Enter your pokemon nickname", isPresented: $showingSaveAlert) {
                    TextField("Enter your pokemon nickname", text: $nickname)
                    Button("Save", action: {
                        save()
                        showingIsSavedAlert.toggle()
                    })
                }
                .alert(isPresented: $showingIsSavedAlert) {
                    Alert(
                        title: Text("Pokemon is saved"),
                        dismissButton: .default(Text("OK")) {
                            showingIsSavedAlert.toggle()
                        }
                    )
                }
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(10)
                .foregroundColor(.black)
                .padding(30)
            }
        }
    }
    
    func save() {
        viewModel.savePokemon(nickname: nickname)
        nickname = ""
    }
}

struct PokemonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoView(viewModel: PokemonInfoViewModel(1))
    }
}
