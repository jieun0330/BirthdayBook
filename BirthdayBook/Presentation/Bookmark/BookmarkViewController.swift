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
    }
    
    private let noBookmarkView = UIView()
    
    private let noBookmarkIcon = UIImageView().then {
        $0.image = .sleepBook
        $0.tintColor = DesignSystemColor.red.color
    }
    
    private let noBookmarkText = UILabel().then {
        $0.text = "저장된 책이 없어요"
        $0.textColor = .systemGray
        $0.font = DesignSystemFont.font12.font
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel.repositoryEmpty() {
            noBookmarkView.isHidden = false
        } else {
            noBookmarkView.isHidden = true
        }
        collectionView.reloadData()
    }
    
    override func configureHierarchy() {
        [collectionView, noBookmarkView].forEach {
            view.addSubview($0)
        }
        
        [noBookmarkIcon, noBookmarkText].forEach {
            noBookmarkView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        noBookmarkView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        noBookmarkIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        noBookmarkText.snp.makeConstraints {
            $0.top.equalTo(noBookmarkIcon.snp.bottom).offset(20)
            $0.centerX.equalTo(noBookmarkIcon)
        }
    }
    
    override func configureView() {
        noBookmarkView.isHidden = true
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
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2.2, height: width / 1.8)
        layout.sectionInset = ConstraintInsets(top: spacing,
                                               left: 15,
                                               bottom: spacing,
                                               right: 15)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        
        return layout
    }
}

extension BookmarkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.repositoryItemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
