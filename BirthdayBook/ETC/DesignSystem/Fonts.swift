//
//  Fonts.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/11/24.
//

import UIKit

enum DesignSystemFont {
    case bookTitle
    case author
}

extension DesignSystemFont {
    var font: UIFont {
        switch self {
        case .bookTitle:
            return .systemFont(ofSize: 15)
        case .author:
            return .systemFont(ofSize: 12)
        }
    }
}
