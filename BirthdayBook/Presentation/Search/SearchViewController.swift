//
//  SearchViewController.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/15/24.
//

import UIKit
import Then
import SnapKit

final class SearchViewController: BaseViewController {
    
    private let viewModel = SearchViewModel()
    private var bookAPIResult: [Doc] = []

    private lazy var searchBar = UISearchBar().then {
        $0.placeholder = "책 검색"
        $0.delegate = self
    }
    
    private lazy var tableView = UITableView().then {
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        $0.delegate = self
        $0.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [searchBar, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.setBackgroundColor()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookAPIResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,
                                                 for: indexPath) as! SearchTableViewCell
        
        cell.selectionStyle = .none
        
        let book = bookAPIResult[indexPath.item]
        
        if bookAPIResult.count > 10 {
            cell.title.text = book.title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchBarText = searchBar.text else { return }
        viewModel.inputBookTitle.value = searchBarText
        
        viewModel.outputNationalLibraryAPIResult.bind { data in
            self.bookAPIResult = data
            self.tableView.reloadData()
        }
    }
}
