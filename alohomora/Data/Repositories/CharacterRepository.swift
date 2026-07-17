//
//  CharacterRepository.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

final class CharacterRepository: CharacterRepositoryProtocol {
    private let apiClient: RequestProtocol

    init(apiClient: RequestProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }

    func fetchCharacters() async throws -> [Character] {
        let dtos: [CharacterDTO] = try await apiClient.request(target: CharacterRequest.all)
        return dtos.compactMap { $0.toDomain() }
    }

    func fetchCharacter(id: String) async throws -> Character? {
        let dto: CharacterDTO = try await apiClient.request(target: CharacterRequest.byId(id: id))
        return dto.toDomain()
    }

    func fetchCharacters(house: String) async throws -> [Character] {
        let dtos: [CharacterDTO] = try await apiClient.request(target: CharacterRequest.byHouse(house: house))
        return dtos.compactMap { $0.toDomain() }
    }
}
