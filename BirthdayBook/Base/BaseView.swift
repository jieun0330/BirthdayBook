//
//  BaseView.swift
//  BirthdayBook
//
//  Created by 박지은 on 5/18/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
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
