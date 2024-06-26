//
//  Aladin.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/12/24.
//

import Foundation

struct Aladin: Decodable {
    let item: [Item]

    enum CodingKeys: String, CodingKey {
        case item
    }
}

struct Item: Decodable, BookDataProtocol {
    let title: String // 책 제목
    let link: String // 알라딘 링크 주소
    let author: String // 저자
    let pubDate: String // 출판일
    let bookDescription: String // 책 소개
    let isbn, isbn13: String
    let itemId: Int
    let priceSales, priceStandard: Int
    let cover: String

    enum CodingKeys: String, CodingKey {
        case title, link, author, pubDate
        case bookDescription = "description"
        case isbn, isbn13, itemId
        case priceSales, priceStandard, cover
    }
}
