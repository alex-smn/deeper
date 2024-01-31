//
//  PokemonInfoViewModel.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 30/01/2024.
//

import Foundation

class PokemonInfoViewModel {
    enum LoadingState {
        case loading
        case completed(PokemonDetails)
        case notInited
        case error
    }
    
    @Published var state: LoadingState
    let entryNumber: Int
    private let repository = PokemonInfoRepository()
    
    init(_ entryNumber: Int) {
        self.entryNumber = entryNumber
        self.state = .notInited
        loadData()
    }
    
    private func loadData() {
        Task { [weak self] in
            guard let self else { return }
            
            do {
                self.state = .loading
                let result = try await self.repository.loadDetails(for: entryNumber)
                await self.handleNewData(result)
            } catch {
                print(error.localizedDescription)
                self.state = .error
            }
        }
    }
    
    @MainActor
    private func handleNewData(_ details: PokemonDetails) {
        self.state = .completed(details)
    }
    
    func savePokemon(nickname: String) {
        repository.savePokemon(entryNumber: entryNumber, nickname: nickname)
    }
}
