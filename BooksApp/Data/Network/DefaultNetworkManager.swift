//
//  DefaultNetworkManager.swift
//  BooksApp
//
//  Created by hardip gajera on 17/02/22.
//

import Combine
import Foundation

class DefaultNetworkManager: NetworkManager {
    
    var baseURL: String {
        return "https://api.itbook.store/1.0"
    }
    
    func executeGetRequest(url: URL) -> AnyPublisher<Data, Error> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { (data: Data, response: URLResponse) in
                return data
            }
            .mapError { error in
                return error
            }.eraseToAnyPublisher()
    }
    
}
