//
//  FavoritesRepositoryProtocol.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

protocol FavoritesRepositoryProtocol {
    func getFavorites() -> [String]
    func isFavorite(id: String) -> Bool
    func toggleFavorite(id: String)
}
