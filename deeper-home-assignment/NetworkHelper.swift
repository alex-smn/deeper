//
//  NetworkHelper.swift
//  deeper-home-assignment
//
//  Created by Alexander Livshits on 31/01/2024.
//

import Foundation

class NetworkHelper {
    static func performNetworkRequest<T: Decodable>(url: URL, responseType: T.Type) async throws -> T {
        var request = URLRequest(url: url)
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 5.0
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "Invalid response", code: 0, userInfo: nil)
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedResponse = try jsonDecoder.decode(T.self, from: data)
        return decodedResponse
    }
}
