//
//  UIViewController+Extension.swift
//  BirthdayBook
//
//  Created by 박지은 on 5/18/24.
//

import UIKit

extension UIViewController {
    func pushVC(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
