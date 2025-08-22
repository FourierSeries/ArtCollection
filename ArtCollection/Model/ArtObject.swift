//
//  ArtObject.swift
//  ArtCollection
//
//  Created by Динар Хайруллин on 21.08.2025.
//

import Foundation

struct ArtObjects: Codable {
    let total: Int
    let objectIDs: [Int]
}

struct ArtObject: Codable {
    let objectID: Int
    let primaryImage: String
    let department: String
    let title: String
    let artistRole: String
    let artistPrefix: String
    let artistDisplayName: String
    let artistNationality: String
    let objectDate: String
    let classification: String
}
