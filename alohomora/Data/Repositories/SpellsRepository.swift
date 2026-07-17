//
//  SpellRepository.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

final class SpellsRepository: SpellsRepositoryProtocol {
    private let apiClient: RequestProtocol
    
    init(apiClient: RequestProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func fetchSpells() async throws -> [Spell] {
        let dtos: [SpellDTO] = try await apiClient.request(target: SpellsRequest.getAll)
        return dtos.compactMap { $0.toDomain() }
    }
}
