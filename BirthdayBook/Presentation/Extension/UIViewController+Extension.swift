//
//  UIViewController+Extension.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/7/24.
//

import UIKit

extension UIBarButtonItem {
    static func setBarButtonItem(image: UIImage,
                                 target: Any?,
                                 action: Selector) -> UIBarButtonItem {
        let setBarButton = UIBarButtonItem(image: image,
                                           style: .plain,
                                           target: target,
                                           action: action)
        return setBarButton
    }
}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
