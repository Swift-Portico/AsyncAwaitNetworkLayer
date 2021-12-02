//
//  CharacterModel.swift
//  AsyncAwaitNetworkLayer
//
//  Created by Pradeep's Macbook on 02/12/21.
//

import Foundation

struct CharacterServiceResult: Codable {
    let results: [CharacterResult]
}

struct CharacterResult: Codable {
    let id: Int
    let name: String
}
