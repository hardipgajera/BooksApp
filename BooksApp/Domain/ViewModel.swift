//
//  ViewModel.swift
//  BooksApp
//
//  Created by hardip gajera on 18/02/22.
//

import Foundation

protocol ViewModel {
    var onUpdateUI: (() -> ())? { get set }
    func setUpBinding()
}
