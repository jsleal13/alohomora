//
//  TrunkViewModel.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

enum TrunkViewState {
    case idle
    case loading
    case loaded
    case error(Error)
}

enum TrunkItem {
    case character(Character)
    case spell(Spell)
}

final class TrunkViewModel {
    private let fetchSpellsUseCase: FetchFavoriteSpellsUseCaseProtocol
    private let fetchCharactersUseCase: FetchFavoriteCharactersUseCaseProtocol
    private let toggleFavoriteCharacter: ToggleCharacterFavoriteUseCaseProtocol
    private let toggleFavoriteSpell: ToggleSpellFavoriteUseCaseProtocol
    private(set) var items: [TrunkItem] = []
    
    var onStateChange: ((TrunkViewState) -> Void)?
    
    init(
        fetchSpellsUseCase: FetchFavoriteSpellsUseCaseProtocol,
        fetchCharactersUseCase: FetchFavoriteCharactersUseCaseProtocol,
        toggleFavoriteCharacter: ToggleCharacterFavoriteUseCaseProtocol,
        toggleFavoriteSpell: ToggleSpellFavoriteUseCaseProtocol
    ) {
        self.fetchSpellsUseCase = fetchSpellsUseCase
        self.fetchCharactersUseCase = fetchCharactersUseCase
        self.toggleFavoriteSpell = toggleFavoriteSpell
        self.toggleFavoriteCharacter = toggleFavoriteCharacter
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
                
                onStateChange?(.loaded)
            } catch {
                onStateChange?(.error(error))
            }
        }
    }
    
    func packInTrunk(at index: Int) {
        let item = item(at: index)
        switch item {
        case .character(let character):
            toggleFavoriteCharacter.packInTrunk(character.id)
        
        case .spell(let spell):
            toggleFavoriteSpell.packInTrunk(spell.id)
        default:
            break
        }
    }

    func item(at index: Int) -> TrunkItem? {
        guard items.indices.contains(index) else { return nil }
        return items[index]
    }
}
