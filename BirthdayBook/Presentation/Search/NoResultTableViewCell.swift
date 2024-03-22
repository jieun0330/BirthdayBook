//
//  NoResultTableViewCell.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/17/24.
//

import UIKit
import Then
import SnapKit

final class NoResultTableViewCell: BaseTableViewCell, ReusableProtocol {
        
    private let bookIcon = UIImageView().then {
        $0.image = .sleepBook
        $0.tintColor = DesignSystemColor.red.color
    }
    
    private let noResultText = UILabel().then {
        $0.text = "검색결과가 없어요"
        $0.textColor = .systemGray
        $0.font = DesignSystemFont.font12.font
    }
    
    lazy var bestSellerButton = UIButton().then {
        $0.setTitle("주간 베스트셀러 구경하기", for: .normal)
        $0.backgroundColor = DesignSystemColor.red.color
        $0.layer.cornerRadius = 20
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [bookIcon, noResultText, bestSellerButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        bookIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        noResultText.snp.makeConstraints {
            $0.top.equalTo(bookIcon.snp.bottom).offset(20)
            $0.centerX.equalTo(bookIcon)
        }
        
        bestSellerButton.snp.makeConstraints {
            $0.centerX.equalTo(noResultText)
            $0.top.equalTo(noResultText.snp.bottom).offset(50)
            $0.width.equalTo(250)
            $0.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
