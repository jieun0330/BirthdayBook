//
//  UIViewController+Extension.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/7/24.
//

import UIKit

extension UIView {
    func setBackgroundColor() {
        self.backgroundColor = .white
    }
}

extension UIBarButtonItem {
    static func setLogo(target: Any?, action: Selector) -> UIBarButtonItem {
        let logo = UIBarButtonItem(image: .logo,
                        style: .plain,
                        target: target,
                        action: action)
        return logo
    }
}
