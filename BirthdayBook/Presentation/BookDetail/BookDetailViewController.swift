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
import Toast

final class BookDetailViewController: BaseViewController {
    
    private let vc = AladinWebViewController()
    private var viewModel = BookDetailViewModel()
    
    private lazy var bookMarkButton = UIBarButtonItem.setBarButtonItem(image: .bookmarkIconInactive,
                                                                       target: self,
                                                                       action: #selector(bookMarkButtonClicked))
    
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
    }
    
    private let introductionTitle = UILabel().then {
        $0.text = "책 소개"
    }
    
    private let bookDescription = UILabel().then {
        $0.numberOfLines = 0
        $0.font = DesignSystemFont.font12.font
    }
    
    private lazy var purchaseButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = DesignSystemColor.pink.color
        $0.setTitle("구매하러 가기", for: .normal)
        $0.setTitleColor(DesignSystemColor.red.color, for: .normal)
        $0.addTarget(self, action: #selector(purchaseButtonClicked), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    
        // realm에 있는지 확인
        if viewModel.isBookMarked() {
            bookMarkButton.image = .bookmarkIcon
        } else {
            bookMarkButton.image = .bookmarkIconInactive
        }
    }
    
    override func configureHierarchy() {
        [bookBackgroundImg, bookCoverImg, bookTitle, author,
         introductionTitle, bookDescription, purchaseButton].forEach {
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
            $0.top.equalTo(bookCoverImg.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
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
            $0.bottom.equalTo(purchaseButton.snp.top).offset(-10)
        }
        
        purchaseButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(50)
        }
    }
    
    override func configureView() {
        navigationItem.rightBarButtonItem = bookMarkButton
        view.setBackgroundColor()
    }
    
    // 웹뷰 링크는 ISBN이 아닌 itemID로 들어가야한다
    @objc private func purchaseButtonClicked() {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configure<T: BookDataProtocol>(data: T) {
        
        
        viewModel.configure(data: data)
        viewModel.configure(dataID: data.title)
        
        bookBackgroundImg.kf.setImage(with: URL(string: data.cover))
        bookCoverImg.kf.setImage(with: URL(string: data.cover), options: [.transition(.fade(1))])
        bookTitle.text = data.title
        author.text = data.author
        bookDescription.text = String(htmlEncodedString: data.bookDescription)
        vc.bookISBN = data.itemId
        
        // realm에 있는지 확인
        if viewModel.isBookMarked() {
            bookMarkButton.image = .bookmarkIcon
        } else {
            bookMarkButton.image = .bookmarkIconInactive
        }
    }
    
    @objc private func bookMarkButtonClicked() {
        
        viewModel.bookMarkButtonClicked()
        
        if viewModel.isBookMarked() {
            bookMarkButton.image = .bookmarkIcon
            view.makeToast("즐겨찾기에 저장되었습니다")
            
        } else {
            bookMarkButton.image = .bookmarkIconInactive
            view.makeToast("즐겨찾기에서 삭제되었습니다")
        }
    }
}
