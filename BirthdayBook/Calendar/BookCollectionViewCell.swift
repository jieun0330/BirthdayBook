//
//  BookCollectionViewCell.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import UIKit
import Then
import SnapKit

final class BookCollectionViewCell: BaseCollectionViewCell {
    
//    private let coverImage = UIImageView().then { <#UIImageView#> in
//        <#code#>
//    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    override func configureHierarchy() {
//        [coverImage].forEach {
//            contentView.addSubview($0)
//        }
    }
    
    override func configureConstraints() {
//        coverImage.snp.makeConstraints {
//            $0.top.leading.equalTo(contentView).offset(20)
//        }
    }
    
    override func configureView() {
        <#code#>
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
