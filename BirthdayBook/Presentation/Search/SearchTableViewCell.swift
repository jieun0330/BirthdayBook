//
//  SearchTableViewCell.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/15/24.
//

import UIKit
import Then
import SnapKit

final class SearchTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let bookImage = UIImageView().then {
        $0.backgroundColor = .green
    }
    
    private let bookInfoStackView = UIStackView().then {
        $0.backgroundColor = .red
        $0.axis = .vertical
        $0.alignment = .leading
    }
    
    let title = UILabel().then {
        $0.font = DesignSystemFont.author.font
    }
    
    private let author = UILabel().then {
        $0.text = "박지은"
        $0.font = DesignSystemFont.author.font
    }
    
    private let price = UILabel().then {
        $0.text = "17,000원"
        $0.font = DesignSystemFont.author.font
    }
    
    private let birthdayBox = UIView().then {
        $0.backgroundColor = DesignSystemColor.pink.color
        $0.layer.cornerRadius = 15
    }
    
    private let birthdayBookLabel = UILabel().then {
        $0.text = "3월 30일에 태어난 책이에요"
        $0.font = .systemFont(ofSize: 10)
    }
    
    private let birthdayIcon = UIImageView().then {
        $0.image = UIImage(systemName: "birthday.cake")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [bookImage, bookInfoStackView, birthdayBox, birthdayIcon].forEach {
            contentView.addSubview($0)
        }
        
        [title, author, price].forEach {
            bookInfoStackView.addSubview($0)
        }
        
        [birthdayBookLabel].forEach {
            birthdayBox.addSubview($0)
        }
        
    }
    
    override func configureConstraints() {
        bookImage.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.verticalEdges.equalTo(contentView).inset(40)
            $0.leading.equalTo(contentView).offset(30)
            $0.width.equalTo(80)
        }
        
        bookInfoStackView.snp.makeConstraints {
            $0.leading.equalTo(bookImage.snp.trailing).offset(10)
            $0.verticalEdges.equalTo(contentView).inset(60)
        }
        
        title.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        author.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(title.snp.bottom).offset(10)
        }
        
        price.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
        
        birthdayBox.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-20)
            $0.width.equalTo(130)
            $0.height.equalTo(30)
        }
        
        birthdayBookLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        birthdayIcon.snp.makeConstraints {
            $0.bottom.equalTo(birthdayBox.snp.top)
            $0.trailing.equalTo(birthdayBox.snp.trailing).offset(-10)
            $0.size.equalTo(20)
        }
    }
    
//    override func configureView() {
//
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
