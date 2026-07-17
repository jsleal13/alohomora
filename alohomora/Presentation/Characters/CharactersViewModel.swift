//
//  CharactersViewModel.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import Foundation

enum ViewState<T> {
    case idle
    case loading
    case loaded(T)
    case error(Error)
}

final class CharactersViewModel {
    private let repository: CharacterRepositoryProtocol

    private(set) var characters: [Character] = []

    var onStateChange: ((ViewState<[Character]>) -> Void)?

    init(repository: CharacterRepositoryProtocol = CharacterRepository()) {
        self.repository = repository
    }

    func loadCharacters() {
        onStateChange?(.loading)

        Task {
            do {
                let result = try await repository.fetchCharacters()
                characters = result
                onStateChange?(.loaded(result))
            } catch {
                onStateChange?(.error(error))
            }
        }
    }

    func character(at index: Int) -> Character? {
        guard characters.indices.contains(index) else { return nil }
        return characters[index]
    }

    var numberOfItems: Int {
        characters.count
    }
}
