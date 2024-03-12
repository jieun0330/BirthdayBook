//
//  BookmarkCollectionViewCell.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/11/24.
//

import UIKit
import SnapKit

final class BookmarkCollectionViewCell: BaseCollectionViewCell, ReusableProtocol {
    
    let bookTitle = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    override func configureHierarchy() {
        [bookTitle].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        bookTitle.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(contentView.snp.top).offset(10)
        }
    }
    
    override func configureView() {
//        contentView.backgroundColor = .orange
//        contentView.layer.cornerRadius = 100
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
