//
//  UserDefaultsFavoritesRepository.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import Foundation

final class UserDefaultsFavoritesRepository: FavoritesRepositoryProtocol {
    private let defaults = UserDefaults.standard
    
    func getFavorites(for type: FavoriteType) -> [String] {
        return defaults.stringArray(forKey: type.rawValue) ?? []
    }
    
    func isFavorite(id: String, type: FavoriteType) -> Bool {
        return getFavorites(for: type).contains(id)
    }
    
    func toggleFavorite(id: String, type: FavoriteType) {
        var favorites = Set(getFavorites(for: type))
        
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
        
        defaults.set(Array(favorites), forKey: type.rawValue)
    }
}
