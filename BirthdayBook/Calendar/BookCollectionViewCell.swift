//
//  BookCollectionViewCell.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import UIKit
import Then
import SnapKit

final class BookCollectionViewCell: BaseCollectionViewCell, ReusableProtocol {
    
    let coverImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .yellow
        $0.clipsToBounds = true
    }
     
    let bookTitle = UILabel().then {
        $0.text = "이처럼 사소한 것들"
    }
    
    let author = UILabel().then {
        $0.text = "클레어"
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    override func configureHierarchy() {
        [coverImage, bookTitle, author].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        coverImage.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(5)
            $0.horizontalEdges.equalTo(contentView).inset(5)
            $0.height.equalTo(300)
        }
        
        bookTitle.snp.makeConstraints {
            $0.leading.equalTo(coverImage.snp.leading)
            $0.top.equalTo(coverImage.snp.bottom).offset(5)
            $0.trailing.equalTo(contentView).offset(-5)
        }
        
        author.snp.makeConstraints {
            $0.leading.equalTo(bookTitle.snp.leading)
            $0.top.equalTo(bookTitle.snp.bottom).offset(5)
            $0.trailing.equalTo(contentView).offset(-5)
        }
        
    }
    
//    override func configureView() {
//        <#code#>
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
