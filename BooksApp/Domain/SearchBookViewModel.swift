//
//  SearchBookViewModel.swift
//  BooksApp
//
//  Created by hardip gajera on 18/02/22.
//

import Foundation
import Combine

protocol SearchBookViewModel: ViewModel {
    var searchedBooks: [Book] { get set }
    var searchQuery: PassthroughSubject<String,Never> { get set }
}

class DefaultSearchBookViewModel: SearchBookViewModel {
    
    @Published var searchedBooks: [Book] = []
    @Published var searchBookError: Error?
    var onUpdateUI: (() -> ())?
    let bookRepository: BookRepository
    var searchQuery: PassthroughSubject<String, Never> = .init()
    var cancellable: Set<AnyCancellable> = .init()
    
    init(_ bookRepository: BookRepository = DefaultBookRepository()) {
        self.bookRepository = bookRepository
        setUpBinding()
    }
    
    func setUpBinding() {
        searchQuery
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { query in
                self.searchBook(query: query)
            }
            .store(in: &cancellable)
    }
    
    func searchBook(query: String) {
        bookRepository.searchBooks(query: query)
            .receive(on: DispatchQueue.main)
            .sink { errorCompletion in
                switch errorCompletion {
                case .failure(let e):
                    self.searchBookError = e
                default:
                    break;
                }
                self.onUpdateUI?()
            } receiveValue: { books in
                self.searchedBooks = books
                self.onUpdateUI?()
            }
            .store(in: &cancellable)
    }
}
