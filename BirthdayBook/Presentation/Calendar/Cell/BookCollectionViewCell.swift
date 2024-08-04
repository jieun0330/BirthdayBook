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
        $0.clipsToBounds = true
    }
    
    private let coverBackImage = UIView().then {
        $0.backgroundColor = .white
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.5
    }
    
    let bookTitle = UILabel().then {
        $0.font = DesignSystemFont.font12.font
        $0.textColor = DesignSystemColor.red.color
    }
    
    let author = UILabel().then {
        $0.font = DesignSystemFont.font10.font
        $0.textColor = DesignSystemColor.red.color
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    override func configureHierarchy() {
        [coverBackImage, coverImage, bookTitle, author].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        coverImage.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(5)
            $0.horizontalEdges.equalTo(contentView).inset(5)
            $0.height.equalTo(345)
        }
        
        coverBackImage.snp.makeConstraints {
            $0.size.equalTo(coverImage)
            $0.edges.equalTo(coverImage.snp.edges)
        }
        
        bookTitle.snp.makeConstraints {
            $0.leading.equalTo(coverImage.snp.leading)
            $0.top.equalTo(coverImage.snp.bottom).offset(10)
            $0.trailing.equalTo(contentView).offset(-5)
        }
        
        author.snp.makeConstraints {
            $0.leading.equalTo(bookTitle.snp.leading)
            $0.top.equalTo(bookTitle.snp.bottom).offset(10)
            $0.trailing.equalTo(contentView).offset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
