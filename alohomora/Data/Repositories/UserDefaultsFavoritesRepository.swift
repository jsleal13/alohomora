//
//  UserDefaultsFavoritesRepository.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import Foundation

final class UserDefaultsFavoritesRepository: FavoritesRepositoryProtocol {
    private let defaults = UserDefaults.standard
    private let favoritesKey = "user_favorite_ids"
    
    func getFavorites() -> [String] {
        return defaults.stringArray(forKey: favoritesKey) ?? []
    }
    
    func isFavorite(id: String) -> Bool {
        return getFavorites().contains(id)
    }
    
    func toggleFavorite(id: String) {
        var favorites = Set(getFavorites())
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
        defaults.set(Array(favorites), forKey: favoritesKey)
    }
}
