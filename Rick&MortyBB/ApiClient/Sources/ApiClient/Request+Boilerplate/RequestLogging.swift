//
//RequestLogging.swift
//
//
//  Created by Olav Hartwedt Larsen on 13/10/2023.
//

import Combine
import Foundation

extension URLSession {
    /// Use this instead, to get logging on your requests
    func dataTask(withLogging request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) -> URLSessionDataTask {
        return self.dataTask(with: request) { data, response, error in
            URLRequest.debugPrintYAML(request: request, response: response, received: data, error: error)
            completionHandler(data, response, error)
        }
    }
    
    func data(withLoggingFor request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return (data, response)
        } catch let error {
            URLRequest.debugPrintYAML(request: request, response: nil, received: nil, error: error)
            throw error
        }
    }
}

extension URLRequest {
    
    private static func headerTransform(_ header: [AnyHashable: Any]?, indent: Int) -> String {
        return (header ?? [:]).map { "\(Array(repeating: "    ", count: indent).joined())\($0): \($1)" }.joined(separator: "\n")
    }
    
    private static func dataTransform(_ data: Data?) -> String {
        return data.flatMap { String(data: $0, encoding: .utf8) } ?? "null"
    }
    
    private static func bodyToJson(data: Data?) -> String {
        let logPrettyPrint = true // Set this in some kind of debug place
        if logPrettyPrint {
            if let httpBody = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: httpBody, options: []),
                let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions.prettyPrinted),
                let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                return prettyPrintedString as String
            }
            return ""
        }
    }
    
    private static func debugYAML(request: URLRequest?) -> String? {
        guard let request = request,
            let method = request.httpMethod,
            let url = request.url
            else { return nil }
        
        return """
        Request:
        Method: \(method)
        URL: \(url)
        Header:
        \(headerTransform(request.allHTTPHeaderFields, indent: 2))
        Body: \(bodyToJson(data: request.httpBody))
        """
    }
    
    private static func debugCURL(request: URLRequest?) -> String? {
        guard let request = request,
            let httpMethod = request.httpMethod,
            let url = request.url, let allHTTPHeaderFields = request.allHTTPHeaderFields else { return nil }
        let bodyComponents: [String]
        if let data = request.httpBody.flatMap({ String(data: $0, encoding: .utf8) }) {
            bodyComponents = ["-d", "'\(data)'"]
        } else {
            bodyComponents = [String]()
        }
        let method = "-X \(httpMethod)"
        let headers = allHTTPHeaderFields.map { "-H '\($0.key): \($0.value)'" }
        return ((["curl", method] + headers + bodyComponents + ["-v"] + [url.absoluteString]) as [String])
            .joined(separator: " ")
    }
    
    private static func debugYAML(response: URLResponse?, data: Data?) -> String? {
        guard let response = response as? HTTPURLResponse else { return nil }
        return """
        Response:
            Code: \(response.statusCode)
            Header:
        \(headerTransform(response.allHeaderFields, indent: 2))
        Body: \(bodyToJson(data: data))
        """
    }
    
    private static func debugYAML(responseError error: Error?) -> String? {
        guard let error = error else { return nil }
        return """
        Response:
            Error: \(error)
        """
    }
    
    private static func curlPrintable(request: URLRequest?) -> String {
        if let string = debugCURL(request: request) {
            return """
                # cURL format:
                # \(string)
                #######################
                """
        }
        return ""
    }
    
    fileprivate static func debugPrintYAML(request: URLRequest?, response: URLResponse?, received: Data?, error: Error? = nil) {
        let responseYaml = debugYAML(responseError: error) ?? debugYAML(response: response, data: received)
        let yaml = [debugYAML(request: request), responseYaml]
            .compactMap { $0 }
            .joined(separator: "\n")
        let info = """
        #######################
        ##### Request Log #####
        #######################
        \(curlPrintable(request: request))
        # YAML format:
        \(yaml)
        #######################
        """
        print("\n\(info)\n")
    }
}

// For Combine requests
extension Publisher where Output == (data: Data, response: URLResponse),
                            Self == URLSession.DataTaskPublisher
{
    public func sinkWithLogging(completion: @escaping (Subscribers.Completion<Self.Failure>) -> Void, receiveValue: @escaping ((_ data: Data, _ response: URLResponse) -> ())) -> AnyCancellable {
        
        return self.sink { error in
            if case .failure(let error) = error {
                URLRequest.debugPrintYAML(request: self.request, response: nil, received: nil, error: error)
            }
            completion(error)
        } receiveValue: { data, response in
            URLRequest.debugPrintYAML(request: self.request, response: response, received: data)
            receiveValue(data, response)
        }
    }
}
