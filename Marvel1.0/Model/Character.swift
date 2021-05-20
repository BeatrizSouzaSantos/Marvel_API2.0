//
//  Character.swift
//  Marvel1.0
//
//  Created by user195594 on 5/19/21.
//

import SwiftUI

// Model

struct APIResult: Codable {
    var data: APICharacterData
}

struct APICharacterData: Codable {
    var count: Int
    var results: [Character]
}

struct Character: Identifiable,Codable {
    var id: Int
    var name: String
    var description: String
    var tumbnail: [String:String]
    var urls: [[String: String]]
}
