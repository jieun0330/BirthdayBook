//
//  Book.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import Foundation

struct NationalLibrary: Decodable {
    let docs: [Doc]

    enum CodingKeys: String, CodingKey {
        case docs
    }
}

struct Doc: Decodable {
    let author: String // 저자
    let realPublishDate: String
    let titleURL: String // 표지이미지 URL
    let isbn: String // ISBN
    let subject: String // 주제 (KDC 대분류)
    let title: String // 표제
    let publishPredate: String // 출판예정일
    
    enum CodingKeys: String, CodingKey {
        case author = "AUTHOR"
        case realPublishDate = "REAL_PUBLISH_DATE"
        case titleURL = "TITLE_URL"
        case isbn = "EA_ISBN"
        case subject = "SUBJECT"
        case title = "TITLE"
        case publishPredate = "PUBLISH_PREDATE"
    }
}
