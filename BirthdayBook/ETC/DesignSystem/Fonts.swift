//
//  Fonts.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/11/24.
//

import UIKit

enum DesignSystemFont {
    case font15
    case font12
    case font10
}

extension DesignSystemFont {
    var font: UIFont {
        switch self {
        case .font15:
            return .systemFont(ofSize: 15)
        case .font12:
            return .systemFont(ofSize: 12)
        case .font10:
            return .systemFont(ofSize: 10)
        }
    }
}
