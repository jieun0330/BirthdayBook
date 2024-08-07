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
    
    private let bookImage = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let bookImageShadow = UIView().then {
        $0.backgroundColor = .white
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.5
    }
    
    private let bookInfoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
    }
    
    private let title = UILabel().then {
        $0.font = DesignSystemFont.font12.font
    }
    
    private let author = UILabel().then {
        $0.font = DesignSystemFont.font10.font
    }
    
    private let price = UILabel().then {
        $0.text = "가격 미정"
        $0.font = DesignSystemFont.font12.font
    }
    
    private let birthdayBox = UIView().then {
        $0.backgroundColor = DesignSystemColor.pink.color
        $0.layer.cornerRadius = 15
    }
    
    private let birthdayBookLabel = UILabel().then {
        $0.font = DesignSystemFont.font10.font
        $0.textColor = DesignSystemColor.red.color
    }
    
    private let birthdayIcon = UIImageView().then {
        $0.image = UIImage(systemName: "birthday.cake")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [bookImageShadow, bookImage, bookInfoStackView, birthdayBox, birthdayIcon].forEach {
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
        
        bookImageShadow.snp.makeConstraints {
            $0.size.equalTo(bookImage)
            $0.edges.equalTo(bookImage.snp.edges)
        }
        
        bookInfoStackView.snp.makeConstraints {
            $0.leading.equalTo(bookImage.snp.trailing).offset(15)
            $0.verticalEdges.equalTo(contentView).inset(60)
        }
        
        title.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.trailing.equalTo(birthdayIcon.snp.leading).offset(-30)
        }
        
        author.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(title.snp.bottom).offset(10)
            $0.trailing.equalTo(birthdayBox.snp.leading).offset(-5)
        }
        
        price.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
        
        birthdayBox.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-20)
            $0.width.equalTo(60)
            $0.height.equalTo(30)
        }
        
        birthdayBookLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        birthdayIcon.snp.makeConstraints {
            $0.bottom.equalTo(birthdayBox.snp.top)
            $0.centerX.equalTo(birthdayBox)
            $0.size.equalTo(20)
        }
    }
    
    func setData(_ data: Item) {
        title.text = data.title
        bookImage.kf.setImage(with: URL(string: data.cover),
                                   options: [.transition(.fade(1))])
        author.text = data.author
        let date = DateFormatManager.shared.stringToDate(date: data.pubDate)
        birthdayBookLabel.text = date
        let salesPrice = NumberFormatManager.shared.numberFormat(number: data.priceSales)
        price.text = "\(salesPrice)원"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
