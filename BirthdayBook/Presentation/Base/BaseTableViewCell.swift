//
//  BaseTableViewCell.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/10/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    func configureHierarchy() { }
    func configureConstraints() { }
    func configureView() { }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
