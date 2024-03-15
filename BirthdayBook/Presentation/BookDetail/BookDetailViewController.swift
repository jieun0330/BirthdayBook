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
    
    private let repository = BookRepository()
    private let viewModel = DescriptionViewModel()
    var libraryBook: Doc!
    
    private lazy var bookMarkButton = UIBarButtonItem(image: .bookmarkIconInactive.withTintColor(DesignSystemColor.red.color),
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(bookMarkButtonClicked))
    
    private let bookBackgroundImg = UIImageView().then {
        $0.alpha = 0.1
        $0.contentMode = .scaleAspectFill
    }
    
    let bookCoverImg = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.5
    }
    
    let bookTitle = UILabel().then {
        $0.font = DesignSystemFont.bookTitle.font
        $0.textColor = DesignSystemColor.red.color
    }
    
    private let author = UILabel().then {
        $0.font = DesignSystemFont.author.font
        $0.textColor = DesignSystemColor.red.color
    }
    
    private let introductionTitle = UILabel().then {
        $0.text = "책 소개"
        //        $0.layer.borderColor = UIColor.brown.cgColor
        //        $0.layer.borderWidth = 1
    }
    
    let bookDescription = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12)
        //        $0.layer.borderColor = UIColor.blue.cgColor
        //        $0.layer.borderWidth = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let libraryBook else { return }
        viewModel.inputISBN.value = libraryBook.eaIsbn
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
            $0.top.equalTo(bookBackgroundImg.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(20)
        }
        
        bookDescription.snp.makeConstraints {
            $0.top.equalTo(introductionTitle.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func configureView() {
        navigationItem.rightBarButtonItem = bookMarkButton
        view.setBackgroundColor()
    }
    
    func configure(data: Doc) {
        
        bookBackgroundImg.kf.setImage(with: URL(string: data.titleURL))
        bookCoverImg.kf.setImage(with: URL(string: data.titleURL))
        bookTitle.text = data.title
        author.text = data.author
        
        viewModel.outputAladinAPIResult.bind { item in
            self.bookDescription.text = item.first?.description
        }
        
        // realm에 있는지 확인
        if repository.fetchItemTitle(bookTitle: data.title).isEmpty {
            bookMarkButton.image = .bookmarkIconInactive
        } else {
            bookMarkButton.image = .bookmarkIcon
        }
    }
    
    func configure(data: BookRealm) {
        bookBackgroundImg.kf.setImage(with: URL(string: data.imgURL))
        bookCoverImg.kf.setImage(with: URL(string: data.imgURL))
        bookTitle.text = data.title
        author.text = data.title
        
        viewModel.outputAladinAPIResult.bind { item in
            self.bookDescription.text = item.first?.description
        }
        
        // realm에 있는지 확인
        if repository.fetchItemTitle(bookTitle: data.title).isEmpty {
            bookMarkButton.image = .bookmarkIconInactive
        } else {
            bookMarkButton.image = .bookmarkIcon
        }
    }
    
    @objc private func bookMarkButtonClicked() {
        let bookRealm = BookRealm(title: libraryBook.title, imgURL: libraryBook.titleURL, isbn: libraryBook.eaIsbn, bookDescription: bookDescription.text!)
        let bookInRepository = repository.fetchItemTitle(bookTitle: libraryBook.title)
        
        if bookInRepository.contains(where: { data in
            repository.deleteItem(data)
            bookMarkButton.image = .bookmarkIconInactive
            return true
        }) {
            
        } else {
            repository.createRealm(bookRealm)
            bookMarkButton.image = .bookmarkIcon
        }
    }
}
