//
//  UIImageView+Extension.swift
//  BooksApp
//
//  Created by hardip gajera on 18/02/22.
//

import Foundation
import UIKit

extension UIImageView {
    
    func load(imageURL: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
