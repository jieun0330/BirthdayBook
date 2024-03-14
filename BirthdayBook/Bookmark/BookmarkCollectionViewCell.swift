//
//  BookmarkCollectionViewCell.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/11/24.
//

import UIKit
import SnapKit
import Then

final class BookmarkCollectionViewCell: BaseCollectionViewCell, ReusableProtocol {
    
    let bookTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    let bookImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        [bookTitle, bookImage].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        bookTitle.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(contentView.snp.top).offset(15)
            $0.horizontalEdges.equalTo(contentView).inset(10)
        }
        
        bookImage.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(bookTitle.snp.bottom).offset(10)
            $0.bottom.equalTo(contentView).offset(-15)
            $0.horizontalEdges.equalTo(contentView).inset(30)
        }
    }
    
    override func configureView() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
