//
//  SearchBookViewController.swift
//  BooksApp
//
//  Created by hardip gajera on 12/02/22.
//

import UIKit

class SearchBookViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var searchBookViewModel: SearchBookViewModel = DefaultSearchBookViewModel()

    override func setUpComponents() {
        super.setUpComponents()
        tableView.register(UINib(nibName: BookTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: BookTableViewCell.reuseIdentifier)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        searchBookViewModel.onUpdateUI = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

extension SearchBookViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBookViewModel.searchQuery.send(searchText)
    }
}

extension SearchBookViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchBookViewModel.searchedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = searchBookViewModel.searchedBooks[indexPath.row]
        let c = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.reuseIdentifier, for: indexPath) as! BookTableViewCell
        c.configure(item)
        return c
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = searchBookViewModel.searchedBooks[indexPath.row]
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailBookViewController.self)) as! DetailBookViewController
        detailViewController.bookIsbn13 = item.isbn13
        present(detailViewController, animated: true)
    }
}
