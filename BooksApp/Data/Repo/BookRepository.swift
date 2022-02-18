//
//  BookRepository.swift
//  BooksApp
//
//  Created by hardip gajera on 17/02/22.
//

import Foundation
import Combine

protocol BookRepository {
    
    func getNewReleasesBooks() -> AnyPublisher<[Book],Error>
    
    func searchBooks(query: String) -> AnyPublisher<[Book],Error>
    
    func getBookDetail(isbn13: String) -> AnyPublisher<DetailBook, Error>
    
}
