//
//  NewBookListViewController.swift
//  BooksApp
//
//  Created by hardip gajera on 12/02/22.
//

import UIKit

class NewBookListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var bookListViewModel: NewBookListViewModel = DefaultNewBookListViewModel()
    
    override func setUpComponents() {
        super.setUpComponents()
        tableView.register(UINib(nibName: BookTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: BookTableViewCell.reuseIdentifier)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        bookListViewModel.onUpdateUI = { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

extension NewBookListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookListViewModel.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = bookListViewModel.bookList[indexPath.row]
        let c = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.reuseIdentifier, for: indexPath) as! BookTableViewCell
        c.configure(item)
        return c
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = bookListViewModel.bookList[indexPath.row]
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailBookViewController.self)) as! DetailBookViewController
        detailViewController.bookIsbn13 = item.isbn13
        present(detailViewController, animated: true)
    }
    
}

