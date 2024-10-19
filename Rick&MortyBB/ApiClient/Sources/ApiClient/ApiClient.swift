// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import Dependencies

public struct ApiClient {
    public var getCharacters: () async throws -> Characters
    public var getCharacter: (_ id: String) async throws -> Character
    public var getEpisodes: () async throws -> Episodes
    public var getLocations: () async throws -> Locations
}

extension URL {
    public static var api = URL.init(string: "https://rickandmortyapi.com/api/")!
}

extension ApiClient: DependencyKey {
  public static var liveValue: ApiClient = .live(baseURL: .api)
  public static var previewValue: ApiClient = .demo
}

public extension DependencyValues {
  var apiClient: ApiClient {
    get { self[ApiClient.self] }
    set { self[ApiClient.self] = newValue }
  }
}

public extension ApiClient {
    static func live(baseURL: URL) -> ApiClient {
        return ApiClient {
            try await Request.with(baseURL: baseURL, path: ["character"], method: .get, response: Characters.self)
        } getCharacter: { id in
            try await Request.with(baseURL: baseURL, path: ["character", id], method: .get, response: Character.self)
        } getEpisodes: {
            try await Request.with(baseURL: baseURL, path: ["episode"], method: .get, response: Episodes.self)
        } getLocations: {
            try await Request.with(baseURL: baseURL, path: ["location"], method: .get, response: Locations.self)
        }
    }
    
    static var demo: ApiClient = Self.init {
        return .mock
    } getCharacter: { id in
        return .mock
    } getEpisodes: {
        return .mock
    } getLocations: {
        return .mock
    }
}

