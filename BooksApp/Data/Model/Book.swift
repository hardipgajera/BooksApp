//
//  Book.swift
//  BooksApp
//
//  Created by hardip gajera on 17/02/22.
//

import Foundation

// MARK: - Book
struct Book: Codable {
    let title, subtitle, isbn13, price: String?
    let image: String?
    let url: String?
}
