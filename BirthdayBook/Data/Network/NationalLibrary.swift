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
    let eaIsbn: String // ISBN
    let subject: String // 주제 (KDC 대분류)
    let title: String // 표제
    let publishPredate: String // 출판예정일

    enum CodingKeys: String, CodingKey {
        case author = "AUTHOR"
        case realPublishDate = "REAL_PUBLISH_DATE"
        case titleURL = "TITLE_URL"
        case eaIsbn = "EA_ISBN"
        case subject = "SUBJECT"
        case title = "TITLE"
        case publishPredate = "PUBLISH_PREDATE"
    }
}



//struct NationalLibrary: Decodable {
//    let totalCount: String // 전체 출력수
//    let docs: [Doc]
//    let pageNo: String // 현재 쪽번호
//
//    enum CodingKeys: String, CodingKey {
//        case totalCount = "TOTAL_COUNT"
//        case docs
//        case pageNo = "PAGE_NO"
//    }
//}
//
//struct Doc: Decodable {
//    let eaAddCode: String // ISBN 부가기호
//    let author: String // 저자
//    let setIsbn: String // 세트 ISBN
//    let realPublishDate: String
//    let titleURL: String // 표지이미지 URL
//    let bookIntroductionURL: String // 책소개
//    let bookSummaryURL: String // 책요약
//    let realPrice: String
//    let eaIsbn: String // ISBN
//    let subject: String // 주제 (KDC 대분류)
//    let title: String // 표제
//    let publishPredate: String // 출판예정일
//    let setAddCode: String // 세트 ISBN 부가기호
//
//    enum CodingKeys: String, CodingKey {
//        case eaAddCode = "EA_ADD_CODE"
//        case author = "AUTHOR"
//        case setIsbn = "SET_ISBN"
//        case realPublishDate = "REAL_PUBLISH_DATE"
//        case titleURL = "TITLE_URL"
//        case bookIntroductionURL = "BOOK_INTRODUCTION_URL"
//        case bookSummaryURL = "BOOK_SUMMARY_URL"
//        case realPrice = "REAL_PRICE"
//        case eaIsbn = "EA_ISBN"
//        case subject = "SUBJECT"
//        case title = "TITLE"
//        case publishPredate = "PUBLISH_PREDATE"
//        case setAddCode = "SET_ADD_CODE"
//    }
//}

