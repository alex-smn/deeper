//
//  DataSourcesEndToEndTest.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 31/01/2024.
//

import XCTest
@testable import deeper_home_assignment

final class DataSourcesEndToEndTest: XCTestCase {
    func testLoadPokemonList() async throws {
        let pokedexDataSource = PokedexNetworkDataSource()
        
        do {
            let result = try await pokedexDataSource.loadPokemonList()
            XCTAssertTrue(result.count > 0)
        } catch {
            XCTFail()
        }
    }
    
    func testLoadPokemonDetails() async throws {
        let detailsDataSource = PokemonDetailsNetworkDataSource()
        
        do {
            let result = try await detailsDataSource.loadPokemonDetails(for: 7)
            XCTAssertEqual(result.id, 7)
            XCTAssertEqual(result.name, "squirtle")
        } catch {
            XCTFail()
        }
    }
}
