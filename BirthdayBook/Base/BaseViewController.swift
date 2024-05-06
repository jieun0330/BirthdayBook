//
//  BaseViewController.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/7/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureConstraints()
        configureView()
        bind()
        view.backgroundColor = .white
    }
    
    func configureHierarchy() { }
    func configureConstraints() { }
    func configureView() { }
    func bind() { }
    
    deinit {
        print(self)
    }
}
