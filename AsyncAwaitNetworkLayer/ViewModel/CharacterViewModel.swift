//
//  CharacterViewModel.swift
//  AsyncAwaitNetworkLayer
//
//  Created by Pradeep's Macbook on 02/12/21.
//

import Combine

class CharacterViewModel: ObservableObject {
    
    enum State {
        case na
        case loading
        case success(data: [CharacterResult])
        case error(_ message: Error)
    }
    
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    
    private let service: CharacterService
    
    init(service: CharacterService) {
        self.service = service
    }
    
    func getCharacters() async {
        
        self.state = .loading
        self.hasError = false
        
        do {
            let results = try await self.service.fetchCharacters()
            self.state = .success(data: results)
        } catch {
            self.state = .error(error)
            self.hasError = true
        }
    }
}
