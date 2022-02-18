//
//  NetworkManager.swift
//  BooksApp
//
//  Created by hardip gajera on 17/02/22.
//

import Foundation
import Combine

protocol NetworkManager {
    
    var baseURL: String { get }
    
    func executeGetRequest( url: URL) -> AnyPublisher<Data,Error>
    
}
