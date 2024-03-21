//
//  SettingTableViewCell.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/21/24.
//

import UIKit
import SnapKit
import Then

final class SettingTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let settingTitle = UILabel().then {
        $0.font = DesignSystemFont.font12.font
    }
    
    let version = UILabel().then {
        $0.font = DesignSystemFont.font12.font
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [settingTitle, version].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        settingTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(contentView).offset(30)
        }
        
        version.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(contentView).offset(-30)
        }
    }
    
//    override func configureView() {
//        <#code#>
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
