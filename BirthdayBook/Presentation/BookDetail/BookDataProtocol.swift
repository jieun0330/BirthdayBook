//
//  BookDataProtocol.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/17/24.
//

import Foundation

protocol BookDataProtocol {
    var cover: String { get }
    var title: String { get }
    var isbn: String { get }
    var author: String { get }
    var bookDescription: String { get }
}
