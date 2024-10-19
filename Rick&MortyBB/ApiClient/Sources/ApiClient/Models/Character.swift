//
//  CharacterModel.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 04/09/2023.
//

import Foundation

public struct Characters: Codable {
    public let results: [Character]
}

public enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
}

public enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

public struct Character: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let status: Status
    public let species: String
    public let type: String?
    public let gender: Gender
    public let origin: Origin
    public let location: Location
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
    

    public var genderIcon: String {
        switch self.gender {
        case .male:
            return "male-icon"
        case .female:
            return "female-icon"
        case .genderless:
            return "unknown-icon"
        default:
            return "unknown-icon"
        }
    }
    
    public var statusIcon: String {
        switch self.status {
        case .alive:
            return "alive-icon"
        case .dead:
            return "dead-icon"
        case .unknown:
            return "unknown-icon"
        default:
            return "unknown-icon"
        }
    }
    
    public func speciesIcon(for species: String) -> String {
        switch species {
        case "Alien":
            return "alien-icon"
        case "Human":
            return "human-icon"
        default:
            return "unknown-icon"
        }
    }
}

public struct Origin: Codable {
    public  let name: String
    public let url: String
}

public extension Characters {
    public static let mock = Characters(results: [.mock, .mock2, .mock])
}

public extension Character {
    public static let mock = Character(
        id: 1,
        name: "Mock Character",
        status: Status.alive,
        species: "Human",
        type: "Main",
        gender: Gender.female,
        origin: Origin(name: "Earth", url: "https://example.com/earth"),
        location: Location(
           id: 1,
           name: "Mock Location",
           type: "Mock Type",
           dimension: "Mock Dimension",
           residents: ["Resident 1", "Resident 2"],
           url: "https://example.com/mock_location",
           created: "2023-09-14T12:00:00Z"
        ),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: ["Episode 1", "Episode 2"],
        url: "https://example.com/character/1",
        created: "2023-09-14T12:00:00Z"
    )
    
    public static let mock2 = Character(
        id: 2,
        name: "Mock Character",
        status: Status.alive,
        species: "Human",
        type: "Main",
        gender: Gender.male,
        origin: Origin(name: "Earth", url: "https://example.com/earth"),
        location: Location(
           id: 1,
           name: "Mock Location",
           type: "Mock Type",
           dimension: "Mock Dimension",
           residents: ["Resident 1", "Resident 2"],
           url: "https://example.com/mock_location",
           created: "2023-09-14T12:00:00Z"
        ),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: ["Episode 1", "Episode 2"],
        url: "https://example.com/character/1",
        created: "2023-09-14T12:00:00Z"
    )
}
