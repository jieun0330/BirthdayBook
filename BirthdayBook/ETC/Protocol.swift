//
//  Protocol.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import Foundation

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension ReusableProtocol {
    static var identifier : String {
        return String(describing: self)
    }
}
