//
//  BookDetailView.swift
//  BirthdayBook
//
//  Created by 박지은 on 5/18/24.
//

import UIKit
import Then

final class BookDetailView: BaseView {
    
    private let bookBackgroundImg = UIImageView().then {
        $0.alpha = 0.1
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let bookCoverImg = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.5
    }
    
    private let bookTitle = UILabel().then {
        $0.font = DesignSystemFont.font15.font
        $0.textColor = DesignSystemColor.red.color
        $0.textAlignment = .center
    }
    
    private let author = UILabel().then {
        $0.font = DesignSystemFont.font12.font
        $0.textColor = DesignSystemColor.red.color
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let introductionTitle = UILabel().then {
        $0.text = "책 소개"
    }
    
    private let bookDescription = UITextView().then {
        $0.font = DesignSystemFont.font12.font
        $0.sizeToFit()
        $0.isEditable = false
    }
    
    lazy var purchaseButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = DesignSystemColor.pink.color
        $0.setTitle("구매하러 가기", for: .normal)
        $0.setTitleColor(DesignSystemColor.red.color, for: .normal)
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    override func configureHierarchy() {
        [bookBackgroundImg, bookCoverImg, bookTitle, author,
         introductionTitle, bookDescription, purchaseButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureConstraints() {
        bookBackgroundImg.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.6)
        }
        
        bookCoverImg.snp.makeConstraints {
            $0.center.equalTo(bookBackgroundImg)
            $0.width.equalTo(152)
            $0.height.equalTo(255)
        }
        
        bookTitle.snp.makeConstraints {
            $0.top.equalTo(bookCoverImg.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        author.snp.makeConstraints {
            $0.top.equalTo(bookTitle.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        introductionTitle.snp.makeConstraints {
            $0.top.equalTo(bookBackgroundImg.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(20)
        }
         
        bookDescription.snp.makeConstraints {
            $0.top.equalTo(introductionTitle.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.bottom.greaterThanOrEqualTo(purchaseButton.snp.top).offset(-10)
        }
        
        purchaseButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(50)
        }
    }
    
    func setData<T: BookDataProtocol>(_ data: T) {
        bookBackgroundImg.kf.setImage(with: URL(string: data.cover))
        bookCoverImg.kf.setImage(with: URL(string: data.cover), options: [.transition(.fade(1))])
        bookTitle.text = data.title
        author.text = data.author
        bookDescription.text = String(htmlEncodedString: data.bookDescription)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
