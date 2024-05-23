//
//  SearchViewController.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/15/24.
//

import UIKit
import SnapKit

final class SearchViewController: BaseViewController {
    
    private let viewModel = SearchViewModel()
    
    private lazy var logo = UIBarButtonItem.setBarButtonItem(image: .logo,
                                                             target: self,
                                                             action: #selector(logoClicked))
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "책 검색"
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NoResultTableViewCell.self,
                    forCellReuseIdentifier: NoResultTableViewCell.identifier)
        tableView.register(SearchTableViewCell.self,
                    forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
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
        navigationItem.leftBarButtonItem = logo
    }
    
    override func bind() {
        viewModel.outputAladinAPIResult.bind { [weak self] _ in
            guard let self else { return }
            self.tableView.reloadData()
        }
    }
    
    @objc private func logoClicked() { }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.outputAladinAPIResult.value.isEmpty {
            return 1
        } else {
            return viewModel.outputAladinAPIResult.value.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !viewModel.outputAladinAPIResult.value.isEmpty {
            
            tableView.isScrollEnabled = true
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,
                                                     for: indexPath) as! SearchTableViewCell
            cell.selectionStyle = .none
            
            let book = viewModel.outputAladinAPIResult.value[indexPath.item]
            cell.title.text = book.title
            cell.bookImage.kf.setImage(with: URL(string: book.cover),
                                       options: [.transition(.fade(1))])
            cell.author.text = book.author
            let date = DateFormatManager.shared.stringToDate(date: book.pubDate)
            cell.birthdayBookLabel.text = date
            let price = NumberFormatManager.shared.numberFormat(number: book.priceSales)
            cell.price.text = "\(price)원"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoResultTableViewCell.identifier,
                                                     for: indexPath) as! NoResultTableViewCell
            
            cell.selectionStyle = .none
            tableView.separatorStyle = .none
            tableView.isScrollEnabled = false
            cell.bestSellerButton.addTarget(self,
                                            action: #selector(bestSellerButtonClicked),
                                            for: .touchUpInside)
            
            return cell
        }
    }
    
    @objc private func bestSellerButtonClicked() {
        viewModel.inputBestSeller.value = ()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if viewModel.outputAladinAPIResult.value.isEmpty {
            return 550
        } else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        view.endEditing(true)
        
        if viewModel.outputAladinAPIResult.value.count != 0 {
            let vc = BookDetailViewController()
            vc.configure(data: viewModel.outputAladinAPIResult.value[indexPath.item])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchBarText = searchBar.text else { return }
        viewModel.inputBookTitle.value = searchBarText
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.outputAladinAPIResult.value.removeAll()
        tableView.reloadData()
    }
}
