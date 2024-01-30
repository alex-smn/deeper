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
    
    @State private var hideTabBar = true
    @State private var showingAlert = false
    @State private var nickname = ""
    
    var body: some View {
        NavigationView {
            if let details = viewModel.model.details {
                ZStack {
                    Color(.lightGray).ignoresSafeArea()
                    
                    VStack(alignment: .center) {
                        
                        ZStack {
                            HStack {
                                Text(String(viewModel.model.entryNumber))
                                Text(viewModel.model.name)
                            }
                            HStack {
                                Spacer()
                                Button(action: {
                                    hideTabBar = false
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.trailing, 30.0)
                        }
                        .padding(.top, 30.0)
                        
                        Spacer()
                        
                        if let url = URL(string: details.imageUrl) {
                            KFImage(url)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("Height: \(details.height)")
                            Text("HP: \(details.hp)")
                        }
                        
                        HStack {
                            Text("Attack: \(details.attack)")
                            Text("Defense: \(details.defense)")
                            Text("Speed: \(details.speed)")
                        }
                        
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("Abilities:")
                                ForEach(details.abilities, id: \.self) { ability in
                                    Text("- \(ability)")
                                }
                            }
                            .padding(.horizontal)
                            
                            Spacer()
                            
                            ScrollView {
                                VStack(alignment: .leading) {
                                    Text("Moves:")
                                    ForEach(details.moves, id: \.self) { move in
                                        Text("- \(move)")
                                    }
                                }
                            }
                            .frame(maxHeight: 200)
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                        
                        Button("Save") {
                            showingAlert.toggle()
                        }
                        .alert("Enter your pokemon nickname", isPresented: $showingAlert) {
                            TextField("Enter your pokemon nickname", text: $nickname)
                            Button("Save", action: save)
                        }

                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .padding(20)
                    }
                }
            } else {
                ZStack {
                    VStack {
                        RoundedRectangle(cornerRadius: 12).foregroundColor(.gray)
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                hideTabBar = false
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.black)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 30.0)
                    .padding(.trailing, 30.0)
                    
                    VStack(alignment: .center) {
                        HStack {
                            Text(String(viewModel.model.entryNumber))
                            Text(viewModel.model.name)
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .toolbar(hideTabBar ? .hidden : .visible, for: .tabBar) // TODO: animation
    }
    
    func save() {
        viewModel.savePokemon(viewModel.model, nickname: nickname)
    }
}

struct PokemonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoView(viewModel: PokemonInfoViewModel(model: PokemonModel.preview, dataSource: PokemonInfoDataSource()))
    }
}

extension PokemonModel {
    static var preview = PokemonModel(
        entryNumber: 1,
        name: "Bulbasaur",
        infoUrl: "",
        details: PokemonDetailsModel(
            imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
            abilities: ["pressure", "overgrow", "chlorophyll"],
            moves: ["fire-punch", "ice-punch","fire-punch", "ice-punch","fire-punch", "ice-punch","fire-punch", "ice-punch"],
            height: 150,
            hp: 100,
            attack: 50,
            defense: 45,
            specialAttack: 75,
            specialDefense: 60,
            speed: 5
        )
    )
}
