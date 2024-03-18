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

    private let iconBackground = UIView().then {
        $0.backgroundColor = DesignSystemColor.pink.color
        $0.layer.cornerRadius = 60
    }
    
    private let bookIcon = UIImageView().then {
        $0.image = .sleepBook
    }
    
    private let noResultText = UILabel().then {
        $0.text = "검색결과가 없어요"
    }
    
    private let bestSellerButton = UIButton().then {
        $0.setTitle("주간 베스트셀러 구경하기", for: .normal)
        $0.backgroundColor = DesignSystemColor.red.color
        $0.layer.cornerRadius = 15
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [iconBackground, bookIcon, noResultText, bestSellerButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        iconBackground.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.size.equalTo(200)
        }
        
        bookIcon.snp.makeConstraints {
            $0.center.equalTo(iconBackground)
            $0.size.equalTo(100)
        }
        
        noResultText.snp.makeConstraints {
            $0.top.equalTo(iconBackground.snp.bottom).offset(5)
            $0.centerX.equalTo(bookIcon)
        }
        
        bestSellerButton.snp.makeConstraints {
            $0.centerX.equalTo(noResultText)
            $0.top.equalTo(noResultText.snp.bottom).offset(50)
            $0.width.equalTo(250)
        }
    }
    
//    override func configureView() {
//        
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
