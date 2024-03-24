//
//  NoBookmarkViewController.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/24/24.
//

import UIKit
import Then
import SnapKit

final class NoBookmarkViewController: BaseViewController {
    
    private let bookIcon = UIImageView().then {
        $0.image = .sleepBook
        $0.tintColor = DesignSystemColor.red.color
    }
    
    private let noBookmarkText = UILabel().then {
        $0.text = "저장된 책이 없어요"
        $0.textColor = .systemGray
        $0.font = DesignSystemFont.font12.font
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [bookIcon, noBookmarkText].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        bookIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        noBookmarkText.snp.makeConstraints {
            $0.top.equalTo(bookIcon.snp.bottom).offset(20)
            $0.centerX.equalTo(bookIcon)
        }
    }
}
