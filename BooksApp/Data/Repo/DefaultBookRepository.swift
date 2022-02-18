//
//  DefaultBookRepository.swift
//  BooksApp
//
//  Created by hardip gajera on 17/02/22.
//

import Foundation
import Combine

class DefaultBookRepository: BookRepository {
    
    let networkManager: NetworkManager
    
    init(_ networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }
    
    struct GenricBookResponse: Codable {
        let total: String?
        let books: [Book]?
    }
   
    func getNewReleasesBooks() -> AnyPublisher<[Book], Error> {
        let urlString = networkManager.baseURL + "/new"
        return networkManager.executeGetRequest(url: URL(string: urlString)!)
            .tryMap { data -> [Book] in
                let decoder = JSONDecoder()
                let value = try decoder.decode(GenricBookResponse.self, from: data)
                return value.books!
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func searchBooks(query: String) -> AnyPublisher<[Book], Error> {
        let urlString = networkManager.baseURL + "/search/\(query)"
        return networkManager.executeGetRequest(url: URL(string: urlString)!)
            .tryMap { data -> [Book] in
                let decoder = JSONDecoder()
                let value = try decoder.decode(GenricBookResponse.self, from: data)
                return value.books ?? []
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func getBookDetail(isbn13: String) -> AnyPublisher<DetailBook, Error> {
        let urlString = networkManager.baseURL + "/books/\(isbn13)"
        return networkManager.executeGetRequest(url: URL(string: urlString)!)
            .tryMap { data -> DetailBook in
                let decoder = JSONDecoder()
                let book = try decoder.decode(DetailBook.self, from: data)
                return book
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
