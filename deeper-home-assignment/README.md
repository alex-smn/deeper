# Pokedex

## Objective
The Pokedex project aims to develop an iOS application using SwiftUI that provides users with information about various Pokemon species available in the Pokemon universe. It utilizes the data exposed by the [PokeAPI](https://pokeapi.co/) to present details such as name, image, moves, abilities, and stats of different Pokemon.

## Functionalities
### User Interactions
- **View Pokemon Information**: Users can utilize the Pokédex to read about various Pokemons available through the PokeAPI. This includes details like their name and image.
- **Update Pokédex**: Users have the ability to update their Pokédex to indicate which Pokémon they have in their possession and assign nicknames to them.

### Display and Interface
- **View All Pokémons Page**: Main page allows users browse through all available Pokémons.
- **Specific Pokemon Page**: Detailed information about a specific Pokemon is displayed on this page, including moves, abilities, and stats. Users can also save Pokémons to their collection from this page.
- **My Pokemon Page**: Users can view all the Pokémons they have saved so far in their collection.

## Technologies Used
- **SwiftUI**: Used for building the user interface of the iOS application.
- **URLSession** with cache for network requests. Cache is useful since all the data loaded is rarely changed.
- **Async/Await**: Used to perform network requests asynchronously. At first I implemented it using GCD since I'm more expereienced with it but decided to rewrite using async/await to avoid callback hell
- **CoreData**: Used to store "My pokemon" collection.
- **XCTest**: Used for testing requests end to end. 
- **PokeAPI**: The primary data source for obtaining information about various Pokemons.
- **Kingfisher**: To load and cache images. I decided to minimize 3-rd party libraries' usage so [Kingfisher](https://github.com/onevcat/Kingfisher/) is the only one.

## How to Use
To use the Pokedex application:
1. Ensure you have an iOS device or simulator running iOS.
2. Clone the repository to your local machine.
3. Open the project in Xcode.
4. Build and run the application on your device or simulator.
5. Explore various Pokémons, view their details, and save them to your collection.
