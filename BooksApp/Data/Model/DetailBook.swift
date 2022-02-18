//
//  DetailBook.swift
//  BooksApp
//
//  Created by hardip gajera on 18/02/22.
//

import Foundation

// MARK: - DetailBook
struct DetailBook: Codable {
    let error, title, subtitle, authors: String?
    let publisher, isbn10, isbn13, pages: String?
    let year, rating, desc, price: String?
    let image: String?
    let url: String?
    let pdf: [String: String]
}
