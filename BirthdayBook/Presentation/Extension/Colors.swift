//
//  Colors.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/7/24.
//

import UIKit

enum DesignSystemColor {
    case pink
    case red
    case random
}

extension DesignSystemColor {
    var color: UIColor {
        switch self {
        case .pink:
            return .init(red: 243, green: 193, blue: 200)
        case .red:
            return .init(red: 192, green: 50, blue: 60)
        case .random:
            return .init(red: .random(in: 150...255),
                         green: .random(in: 150...255),
                         blue: .random(in: 150...255))
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }
}
