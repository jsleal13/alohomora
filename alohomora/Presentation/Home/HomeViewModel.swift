//
//  HomeViewModel.swift
//  alohomora
//
//  Created by Janine Leal on 14/07/26.
//

enum ViewState {
    case idle
    case loading
    case loaded
    case error(Error)
}

final class HomeViewModel {
    private let mainCharactersUseCase: FetchMainCharactersUseCaseProtocol
    private let charactersByHouseUseCase: FetchCharactersByHouseUseCaseProtocol
    private let toggleFavorite: ToggleCharacterFavoriteUseCaseProtocol
    private(set) var characters: [Character] = []
    var onStateChange: ((ViewState) -> Void)?
    
    init(
        mainCharactersUseCase: FetchMainCharactersUseCaseProtocol,
        charactersByHouseUseCase: FetchCharactersByHouseUseCaseProtocol,
        toggleFavorite: ToggleCharacterFavoriteUseCaseProtocol
    ) {
        self.mainCharactersUseCase = mainCharactersUseCase
        self.charactersByHouseUseCase = charactersByHouseUseCase
        self.toggleFavorite = toggleFavorite
    }

    func loadCharacters() {
        onStateChange?(.loading)

        Task {
            do {
                let result = try await mainCharactersUseCase.execute()
                characters = result
                onStateChange?(.loaded)
            } catch {
                onStateChange?(.error(error))
            }
        }
    }

    func loadCharactersByHouse(house: House) {
        onStateChange?(.loading)
        characters.removeAll()
        
        Task {
            do {
                let result = try await charactersByHouseUseCase.execute(house: house.name)
                characters = result
                onStateChange?(.loaded)
            } catch {
                onStateChange?(.error(error))
            }
        }
        
    }
    
    func packInTrunk(id: String) {
        toggleFavorite.packInTrunk(id)
    }
    
    func checkIfIsPacked(id: String) -> Bool {
        toggleFavorite.checkIfIsFavorite(id)
    }

    func character(at index: Int) -> Character? {
        guard characters.indices.contains(index) else { return nil }
        return characters[index]
    }

    var numberOfItems: Int {
        characters.count
    }
}
