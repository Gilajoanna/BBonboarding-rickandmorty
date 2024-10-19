//
//  Location.swift
//
//
//  Created by Gila Johansson on 23/10/2023.
//

import Foundation

public struct Locations: Codable {
    public let results: [Location]
}

public struct Location: Codable {
    public let id: Int?
    public let name: String
    public let type: String?
    public let dimension: String?
    public let residents: [String]?
    public let url: String
    public let created: String?
}

public extension Locations {
    public static let mock = Locations(results: [.mock])
}

public extension Location {
    public static let mock = Location(
        id: 21,
        name: "Testicle Monster Dimension",
        type: "Dimension",
        dimension: "Testicle Monster Dimension",
        residents: [
          "https://rickandmortyapi.com/api/character/7",
          "https://rickandmortyapi.com/api/character/436"
        ],
        url: "https://rickandmortyapi.com/api/location/21",
        created: "2017-11-18T19:41:01.605Z"
    )
}

