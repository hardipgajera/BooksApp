//
//  DetailBookViewController.swift
//  BooksApp
//
//  Created by hardip gajera on 18/02/22.
//

import UIKit

class DetailBookViewController: BaseViewController {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    var bookIsbn13: String?
    private var searchBookViewModel: BookViewModel?
    
    override func setUpComponents() {
        super.setUpComponents()
        if let bookIsbn13 = bookIsbn13 {
            searchBookViewModel =  DefaultBookViewModel(bookIsbn13: bookIsbn13)
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        searchBookViewModel?.onUpdateUI = { [weak self] in
            guard let book = (self?.searchBookViewModel?.book) else { return }
            self?.loadData(from: book)
        }
    }
    
    func loadData(from book: DetailBook) {
        bookTitleLabel.text = book.title
        bookDescriptionLabel.text = book.desc
        priceLabel.text = book.price
        if let imageURL = URL(string: book.image ?? "") {
            bookImageView.load(imageURL: imageURL)
        }
    }
    
    @IBAction func backButtonDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    
}
