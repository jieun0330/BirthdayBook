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
import RealmSwift

final class BookDetailViewController: BaseViewController {
    
    var libraryBook: Doc!
    private let repository = BookRepository()
    
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
        $0.textColor = DesignSystemColor.red.color
    }
    
    private let author = UILabel().then {
        $0.font = DesignSystemFont.author.font
        $0.textColor = DesignSystemColor.red.color
    }
    
    private let introductionTitle = UILabel().then {
        $0.text = "책 소개"
    }
    
    private let bookDescription = UITextView().then {
        $0.layer.borderColor = UIColor.brown.cgColor
        $0.layer.borderWidth = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        [bookBackgroundImg, bookCoverImg, bookTitle, author, introductionTitle, bookDescription].forEach {
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
        
        author.snp.makeConstraints {
            $0.top.equalTo(bookTitle.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        introductionTitle.snp.makeConstraints {
            $0.top.equalTo(bookBackgroundImg.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
        }
        
        bookDescription.snp.makeConstraints {
            $0.top.equalTo(introductionTitle.snp.bottom).offset(20)
            $0.leading.equalTo(introductionTitle.snp.leading)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        navigationItem.rightBarButtonItem = bookMarkButton
        view.setBackgroundColor()
        bookBackgroundImg.kf.setImage(with: URL(string: libraryBook.titleURL))
        bookCoverImg.kf.setImage(with: URL(string: libraryBook.titleURL))
        bookTitle.text = libraryBook.title
        author.text = libraryBook.author
//        bookDescription.text = libraryBook.debugDescription
    }
    
    @objc private func bookMarkButtonClicked() {
        
        let bookRealm = BookRealm(id: libraryBook.title)
        
        repository.createRealm(bookRealm)
    }
    
}
