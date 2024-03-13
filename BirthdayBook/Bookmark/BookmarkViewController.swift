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
    
    private let repository = BookRepository()
    private var bookRealm: BookRealm!
    private var viewModel = BookmarkViewModel()

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: BookmarkViewController.configureCollectionViewLayout()).then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(BookmarkCollectionViewCell.self,
                    forCellWithReuseIdentifier: BookmarkCollectionViewCell.identifier)
//        $0.backgroundColor = .green
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
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2.2, height: width / 1.8)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        layout.sectionInset = ConstraintInsets(top: spacing, left: 15, bottom: spacing, right: 15)
        
                
        return layout
    }

}

extension BookmarkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repository.fetchAllItem().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarkCollectionViewCell.identifier, for: indexPath) as! BookmarkCollectionViewCell
        
        cell.layer.cornerRadius = 15
        cell.backgroundColor = DesignSystemColor.random.color
        
//        viewModel.inputBookISBN.value =

        return cell
    }
    
    
}



