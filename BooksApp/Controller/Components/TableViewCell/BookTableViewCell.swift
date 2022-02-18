//
//  BookTableViewCell.swift
//  BooksApp
//
//  Created by hardip gajera on 18/02/22.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configure(_ book: Book) {
        titleLabel.text = book.title
        descriptionLabel.text = book.subtitle
        priceLabel.text = book.price
        if let imageURL = URL(string: book.image ?? "") {
            bookImageView.load(imageURL: imageURL)
        }
    }
    
    static var reuseIdentifier: String = "BookTableViewCell"
}
