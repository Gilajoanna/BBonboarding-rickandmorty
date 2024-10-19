//
// Episode.swift
//
//
//  Created by Gila Johansson on 24/10/2023.
//

import Foundation

public struct Episodes: Codable {
    public let results: [Episode]
}

public struct Episode: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let airDate: String
    public let episode: String
    public let characters: [String]
    public let url: String
    public let created: String
    
    public var season: String {
        return String(episode.prefix(3))
    }
    
    public var prettyEpisodeText: String {
        return episode.formatEpisode
    }
    
    public var prettySeasonText: String {
        return episode.formatSeason
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url, created
    }
}

public extension Episodes {
    public static let mock = Episodes(results: [.mock])
}

public extension Episode {
    public static let mock = Episode(
        id: 1,
        name: "Pilot",
        airDate: "December 2, 2013",
        episode: "S01E01",
        characters: ["https://rickandmortyapi.com/api/character/1",
                     "https://rickandmortyapi.com/api/character/2"],
        url: "https://rickandmortyapi.com/api/episode/1",
        created: "2017-11-10T12:56:33.798Z"
    )
}

