//
//  API.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/13/24.
//

import Foundation

enum BookAPI {
    case library(date: String)
    case aladin(isbn: String)
    
    var url: URL {
        switch self {
        case .library(let date):
            return URL(string: "https://www.nl.go.kr/seoji/SearchApi.do?cert_key=\(APIKey.libraryKey)&result_style=json&page_no=1&page_size=100&start_publish_date=2023\(date)&end_publish_date=2023\(date)")!
        case .aladin(let isbn):
            return URL(string: "https://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=\(APIKey.aladinKey)&ItemIdType=ISBN13&ItemId=\(isbn)&Output=js&Version=20131101&OptResult=ebookList,usedList,reviewList.js")!
        }
    }
}
