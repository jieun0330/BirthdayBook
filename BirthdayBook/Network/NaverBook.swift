//
//  NaverBook.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/11/24.
//

import Foundation

struct NaverBook: Decodable {
    let total, start, display: Int
    let items: [Item]
}

struct Item: Decodable {
    let title: String
    let link: String
    let image: String
    let author, discount, publisher, pubdate: String
    let isbn, description: String
}
