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
    
    private lazy var searchBar = UISearchBar().then {
        $0.placeholder = "책 검색"
        $0.delegate = self
    }
    
    private lazy var tableView = UITableView().then {
        $0.register(NoResultTableViewCell.self, forCellReuseIdentifier: NoResultTableViewCell.identifier)
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        $0.delegate = self
        $0.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.outputAladinAPIResult.bind { _ in
            self.tableView.reloadData()
        }
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
        
        if viewModel.outputAladinAPIResult.value.isEmpty {
            return 1
        } else {
            return viewModel.outputAladinAPIResult.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !viewModel.outputAladinAPIResult.value.isEmpty {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,
                                                     for: indexPath) as! SearchTableViewCell
            
            let book = viewModel.outputAladinAPIResult.value[indexPath.item]
            cell.title.text = book.title
            cell.bookImage.kf.setImage(with: URL(string: book.cover), options: [.transition(.fade(1))])
            cell.author.text = book.author
            let date = DateFormatManager.shared.stringToDate(date: book.pubDate)
            cell.birthdayBookLabel.text = "\(date)에 태어난 책이에요"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoResultTableViewCell.identifier,
                                                     for: indexPath) as! NoResultTableViewCell
            
            cell.selectionStyle = .none
            tableView.isScrollEnabled = false
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if viewModel.outputAladinAPIResult.value.isEmpty {
            return 550
        } else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if viewModel.outputAladinAPIResult.value.count != 0 {
            let vc = BookDetailViewController()
            vc.aladinBook = viewModel.outputAladinAPIResult.value[indexPath.item]
            vc.configure(data: viewModel.outputAladinAPIResult.value[indexPath.item])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchBarText = searchBar.text else { return }
        viewModel.inputBookTitle.value = searchBarText
    }
}
