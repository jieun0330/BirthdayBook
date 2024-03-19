//
//  NoBookmarkCollectionViewCell.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/19/24.
//

import UIKit
import Then
import SnapKit

final class NoBookmarkCollectionViewCell: BaseCollectionViewCell, ReusableProtocol {
    
    private let bookIcon = UIImageView().then {
        $0.image = .sleepBook
        $0.tintColor = DesignSystemColor.red.color
    }
    
    private let noBookmarkText = UILabel().then {
        $0.text = "저장된 책이 없어요"
        $0.textColor = .systemGray
        $0.font = DesignSystemFont.font12.font
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    override func configureHierarchy() {
        [bookIcon, noBookmarkText].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        bookIcon.snp.makeConstraints {
            $0.center.equalTo(contentView)
            $0.width.equalTo(100)
        }
        
        noBookmarkText.snp.makeConstraints {
            $0.top.equalTo(bookIcon.snp.bottom).offset(20)
            $0.centerX.equalTo(bookIcon)
        }
    }
    
    //    override func configureView() {
    //    }
    //
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
