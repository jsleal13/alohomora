//
//  HomeViewModel.swift
//  alohomora
//
//  Created by Janine Leal on 14/07/26.
//

enum ViewState<T> {
    case idle
    case loading
    case loaded(T)
    case error(Error)
}

final class HomeViewModel {
    private let useCase: FetchMainCharactersUseCaseProtocol
    private(set) var characters: [Character] = []
    var onStateChange: ((ViewState<[Character]>) -> Void)?

    init(useCase: FetchMainCharactersUseCaseProtocol) {
        self.useCase = useCase
    }

    func loadCharacters() {
        onStateChange?(.loading)

        Task {
            do {
                let result = try await useCase.execute()
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
