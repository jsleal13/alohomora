//
//  FavoritesRepositoryProtocol.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

protocol FavoritesRepositoryProtocol {
    func getFavorites(for type: FavoriteType) -> [String]
    func isFavorite(id: String, type: FavoriteType) -> Bool
    func toggleFavorite(id: String, type: FavoriteType)
}
