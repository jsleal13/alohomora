//
//  SpellbookViewModel.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import Foundation

enum SpellbookViewState<T> {
    case idle
    case loading
    case loaded(T)
    case error(Error)
}

final class SpellbookViewModel {
    private let fetchSpellsUseCase: FetchSpellsUseCaseProtocol
    private var spells: [Spell] = []
    let toggleFavorite: ToggleSpellFavoriteUseCaseProtocol
    var onStateChange: ((SpellbookViewState<[Spell]>) -> Void)?
    
    init(
        fetchSpellsUseCase: FetchSpellsUseCaseProtocol,
        toggleFavorite: ToggleSpellFavoriteUseCaseProtocol
    ) {
        self.fetchSpellsUseCase = fetchSpellsUseCase
        self.toggleFavorite = toggleFavorite
    }
    
    func loadSpells() {
        onStateChange?(.loading)
        
        Task {
            do {
                let result = try await fetchSpellsUseCase.execute()
                spells = result
                onStateChange?(.loaded(result))
            } catch {
                onStateChange?(.error(error))
            }
        }
    }
    
    func spell(at index: Int) -> Spell? {
        guard spells.indices.contains(index) else { return nil }
        return spells[index]
    }
    
    func checkIfIsPackec(id: String) -> Bool {
        toggleFavorite.checkIfIsFavorite(id)
    }
    
    func packInTrunk(id: String) {
        toggleFavorite.packInTrunk(id)
    }
}
