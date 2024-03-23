//
//  BookmarkViewController.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/11/24.
//

import UIKit
import SnapKit
import Then

final class BookmarkViewController: BaseViewController {
    
    private let viewModel = BookMarkViewModel()
    
    private lazy var logo = UIBarButtonItem.setBarButtonItem(image: .logo,
                                                             target: self,
                                                             action: #selector(logoClicked))
    
    private lazy var setting = UIBarButtonItem.setBarButtonItem(image: .list,
                                                                target: self,
                                                                action: #selector(settingClicked))
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: configureCollectionViewLayout()).then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(BookmarkCollectionViewCell.self,
                    forCellWithReuseIdentifier: BookmarkCollectionViewCell.identifier)
        $0.register(NoBookmarkCollectionViewCell.self,
                    forCellWithReuseIdentifier: NoBookmarkCollectionViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func configureHierarchy() {
        [collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.setBackgroundColor()
        navigationItem.leftBarButtonItem = logo
        navigationItem.rightBarButtonItem = setting
    }
    
    @objc private func logoClicked() { }
    
    @objc private func settingClicked() {
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        
        // Realm에 저장되어있는게 없으면
        if viewModel.repositoryEmpty() {
            let width = UIScreen.main.bounds.width
            layout.itemSize = CGSize(width: width / 1.5, height: width / 1.8)
            layout.sectionInset = ConstraintInsets(top: 250,
                                                   left: 15,
                                                   bottom: spacing,
                                                   right: 15)
        } else {
            let width = UIScreen.main.bounds.width - (spacing * 3)
            layout.itemSize = CGSize(width: width / 2.2, height: width / 1.8)
            layout.sectionInset = ConstraintInsets(top: spacing,
                                                   left: 15,
                                                   bottom: spacing,
                                                   right: 15)
        }
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        
        return layout
    }
}

extension BookmarkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.repositoryEmpty() ? 1 : viewModel.repositoryItemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if viewModel.repositoryEmpty() {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoBookmarkCollectionViewCell.identifier,
                                                          for: indexPath)
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarkCollectionViewCell.identifier,
                                                          for: indexPath) as! BookmarkCollectionViewCell
            
            cell.layer.cornerRadius = 15
            cell.backgroundColor = DesignSystemColor.random.color
            
            let repoAll = viewModel.repositoryFetch()
            cell.bookTitle.text = repoAll[indexPath.item].title
            cell.bookImage.kf.setImage(with: URL(string: repoAll[indexPath.item].cover),
                                       options: [.transition(.fade(1))])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = BookDetailViewController()
        let repoAll = viewModel.repositoryFetch()
        let bookRealm = repoAll[indexPath.item]
        let item = Item(title: bookRealm.title,
                        link: "",
                        author: bookRealm.author,
                        pubDate: "",
                        bookDescription: bookRealm.bookDescription,
                        isbn: bookRealm.isbn,
                        isbn13: bookRealm.isbn,
                        itemId: bookRealm.itemId,
                        priceSales: 0,
                        priceStandard: 0,
                        cover: bookRealm.cover)
        vc.configure(data: item)
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
