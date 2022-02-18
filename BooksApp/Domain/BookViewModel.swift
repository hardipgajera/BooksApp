//
//  BookViewModel.swift
//  BooksApp
//
//  Created by hardip gajera on 18/02/22.
//

import Foundation
import Combine

protocol BookViewModel: ViewModel {
    var book: DetailBook? { get set }
    var loadBookError: Error? { get set }
}

class DefaultBookViewModel: BookViewModel {
    
    @Published var book: DetailBook? = nil
    @Published var loadBookError: Error?
    var cancellable: Set<AnyCancellable> = .init()
    var onUpdateUI: (() -> ())?
    let bookRepository: BookRepository
    let bookIsbn13: String
    
    init(_ bookRepository: BookRepository = DefaultBookRepository(),bookIsbn13: String) {
        self.bookRepository = bookRepository
        self.bookIsbn13 = bookIsbn13
        setUpBinding()
    }
    
    func setUpBinding() {
        bookRepository.getBookDetail(isbn13: self.bookIsbn13)
            .receive(on: DispatchQueue.main)
            .sink { errorCompletion in
                switch errorCompletion {
                case .failure(let e):
                    self.loadBookError = e
                default:
                    break;
                }
                self.onUpdateUI?()
            } receiveValue: { book in
                self.book = book
                self.onUpdateUI?()
            }
            .store(in: &cancellable)
    }
    
}
