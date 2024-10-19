//
//Request.swift
//
//
//  Created by Olav Hartwedt Larsen on 13/10/2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

struct Request<P: Encodable, R: Decodable> {
    let parameter: P
    let response: R
    
    static func with(baseURL: URL, path: [String], method: HTTPMethod, parameters: P = Empty(), response: R.Type) async throws -> R {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        urlComponents.path = path
            .reduce(baseURL, { $0.appendingPathComponent($1)})
            .path
        
        var request = URLRequest.init(url: urlComponents.url!)
        request.httpMethod = method.rawValue
        let encoder = JSONEncoder()
        if (parameters is Empty) == false {
            request.httpBody = try encoder.encode(parameters)
        }

        let result: Data = try await withCheckedThrowingContinuation { continuation in
            let task = URLSession.shared.dataTask(withLogging: request) { data, response, error in
                
                switch (data, response, error) {
                    case (_, _, let error?):
                        continuation.resume(throwing: error)
                        
                    case (let data?, let response as HTTPURLResponse, _):
                        if 200...299 ~= response.statusCode {
                            continuation.resume(returning: data)
                        } else {
                            continuation.resume(throwing: BuddyBoardingAPIClientError.statusCode(code: response.statusCode, response: response, data: data))
                        }
                    case (let data?, _, _):
                        continuation.resume(returning: data)
                    default:
                        break
                }
            }
            
            task.resume()
            
        }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .customISO8601
            
            return try decoder.decode(response.self, from: result)
            
        } catch let error as DecodingError {
            throw BuddyBoardingAPIClientError.decodingError(error: error)
        } catch let error {
            throw BuddyBoardingAPIClientError.underlying(error: error)
        }
    }
    
}

struct Empty: Codable { }



extension JSONDecoder.DateDecodingStrategy {
    static let customISO8601 = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        
        let formatter = ISO8601DateFormatter()
        // Insert .withFractionalSeconds to the current format.
        formatter.formatOptions.insert(.withFractionalSeconds)
        

        // Set new format with .withFractionalSeconds
        formatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds
        ]
        if let date = formatter.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}
