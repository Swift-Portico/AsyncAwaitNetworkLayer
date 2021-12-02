//
//  CharacterService.swift
//  AsyncAwaitNetworkLayer
//
//  Created by Pradeep's Macbook on 02/12/21.
//

import Foundation

struct CharacterService {
    
    enum CharacterError: Error {
        case failed
        case failedToDecode
        case invalidStatusCode
    }
    
    func fetchCharacters() async throws -> [CharacterResult] {
        guard let url = URL.init(string: "https://rickandmortyapi.com/api/character") else { return [] }
        let urlSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let (data, response) = try await urlSession.data(from: url, delegate: nil)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CharacterError.invalidStatusCode
        }
        do {
            let decodedData = try JSONDecoder().decode(CharacterServiceResult.self, from: data)
            return decodedData.results
        }
        catch {
            throw CharacterError.failedToDecode
        }
    }
    
}
