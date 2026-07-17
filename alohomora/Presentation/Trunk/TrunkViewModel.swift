//
//  TrunkViewModel.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

enum TrunkViewState<T> {
    case idle
    case loading
    case loaded(T)
    case error(Error)
}

enum TrunkItem {
    case character(Character)
    case spell(Spell)
}

final class TrunkViewModel {
    private let fetchSpellsUseCase: FetchFavoriteSpellsUseCaseProtocol
    private let fetchCharactersUseCase: FetchFavoriteCharactersUseCaseProtocol
    private(set) var items: [TrunkItem] = []
    
    var onStateChange: ((TrunkViewState<[TrunkItem]>) -> Void)?
    
    init(
        fetchSpellsUseCase: FetchFavoriteSpellsUseCaseProtocol,
        fetchCharactersUseCase: FetchFavoriteCharactersUseCaseProtocol
    ) {
        self.fetchSpellsUseCase = fetchSpellsUseCase
        self.fetchCharactersUseCase = fetchCharactersUseCase
    }
    
    func loadFavorites() {
        onStateChange?(.loading)
        
        Task {
            do {
                async let spellsTask = fetchSpellsUseCase.execute()
                async let charactersTask = fetchCharactersUseCase.execute()

                let (fetchedSpells, fetchedCharacters) = try await (spellsTask, charactersTask)
                
                let characterItems = fetchedCharacters.map { TrunkItem.character($0) }
                let spellItems = fetchedSpells.map { TrunkItem.spell($0) }
                
                self.items = characterItems + spellItems
                
                onStateChange?(.loaded(self.items))
            } catch {
                onStateChange?(.error(error))
            }
        }
    }

    func item(at index: Int) -> TrunkItem? {
        guard items.indices.contains(index) else { return nil }
        return items[index]
    }
}
