//
//  NewBookListViewModel.swift
//  BooksApp
//
//  Created by hardip gajera on 18/02/22.
//

import Combine
import Foundation

protocol NewBookListViewModel: ViewModel {
    var bookList: [Book] { get set }
    var loadNewBookError: Error? { get set }
}

class DefaultNewBookListViewModel: NewBookListViewModel {

    @Published var bookList: [Book] = []
    @Published var loadNewBookError: Error?
    var onUpdateUI: (() -> ())?
    let bookRepository: BookRepository
    var cancellable: Set<AnyCancellable> = .init()
    
    init(_ bookRepository: BookRepository = DefaultBookRepository()) {
        self.bookRepository = bookRepository
        setUpBinding()
    }
    
    func setUpBinding() {
        self.bookRepository.getNewReleasesBooks()
            .receive(on: DispatchQueue.main)
            .sink { errorCompletion in
                switch errorCompletion {
                case .failure(let e):
                    self.loadNewBookError = e
                default:
                    break;
                }
                self.onUpdateUI?()
            } receiveValue: { books in
                self.bookList = books
                self.onUpdateUI?()
            }
            .store(in: &cancellable)
    }
    
}
