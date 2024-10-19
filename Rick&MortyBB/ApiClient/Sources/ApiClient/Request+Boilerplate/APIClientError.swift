//
//  APIClientError.swift
//
//
//  Created by Olav Hartwedt Larsen on 13/10/2023.
//

import Foundation

public enum BuddyBoardingAPIClientError: LocalizedError {
    case underlying(error: Error)
    case statusCode(code: Int, response: HTTPURLResponse, data: Data)
    case userGotLoggedOut
    case decodingError(error: DecodingError)

    public var errorDescription: String? {
        switch self {
            case .statusCode(code: let code, response: let response, data: let data):
                return ["Code: \(code)", response.description, String(data: data, encoding: .utf8).map { "JSON: \($0)" }]
                    .compactMap { $0 }
                    .joined(separator: ", ")
            case .underlying(error: let error):
                return String(describing: error)
            case .decodingError(error: let error):
                return String(describing: error)
            case .userGotLoggedOut:
                return "User session is no longer authenticated, user is logged out."
        }
    }
}

extension LocalizedError where Self: CustomStringConvertible {
    var errorDescription: String? {
        return description
    }
}
