//
//  BookViewController.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/11/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher

final class BookViewController: BaseViewController {
    
    var libraryBook: Doc!
    
    private lazy var bookMarkButton = UIBarButtonItem(image: .bookmarkIconInactive.withTintColor(DesignSystemColor.red.color),
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(bookMarkButtonClicked))
    
    private let bookBackgroundImg = UIImageView().then {
        $0.alpha = 0.1
        $0.contentMode = .scaleAspectFill
    }
    
    private let bookCoverImg = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let bookTitle = UILabel().then {
        $0.font = DesignSystemFont.bookTitle.font
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        [bookBackgroundImg, bookCoverImg, bookTitle].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        bookBackgroundImg.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalTo(view)
            $0.height.equalTo(550)
        }
        
        bookCoverImg.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(152)
            $0.height.equalTo(255)
        }
        
        bookTitle.snp.makeConstraints {
            $0.top.equalTo(bookCoverImg.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func configureView() {
        navigationItem.rightBarButtonItem = bookMarkButton
        view.setBackgroundColor()
        bookBackgroundImg.kf.setImage(with: URL(string: libraryBook.titleURL))
        bookCoverImg.kf.setImage(with: URL(string: libraryBook.titleURL))
        bookTitle.text = libraryBook.title
    }
    
    @objc private func bookMarkButtonClicked() {
        
    }
    
}
