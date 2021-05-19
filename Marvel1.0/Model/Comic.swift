//
//  Comic.swift
//  Marvel1.0
//
//  Created by user195594 on 5/19/21.
//

import SwiftUI

struct APIComicResult: Codable {
    var data: APIComicData
}

struct APIComicData: Codable {
    var count: Int
    var results: [Comic]
}

struct Comic: Identifiable,Codable {
    var id: Int
    var title: String
    var description: String?
    var tumbnail: [String:String]
    var urls: [[String: String]]
}

