//
//  API.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/13/24.
//

import Foundation

enum BookAPI {
    case dateLibrary(date: String)
    case isbnLibrary(isbn: String)
    case titleLbirary(title: String)
    case aladin(isbn: String)
    
    var url: URL {
        switch self {
        case .dateLibrary(let date):
            return URL(string: "https://www.nl.go.kr/seoji/SearchApi.do?cert_key=\(APIKey.libraryKey)&result_style=json&page_no=1&page_size=20&start_publish_date=2023\(date)&end_publish_date=2023\(date)")!
        case .isbnLibrary(isbn: let isbn):
            return URL(string: "https://www.nl.go.kr/seoji/SearchApi.do?cert_key=\(APIKey.libraryKey)&result_style=json&page_no=1&isbn=\(isbn)&page_size=1")!
        case .titleLbirary(title: let title):
            return URL(string: "https://www.nl.go.kr/seoji/SearchApi.do?cert_key=\(APIKey.libraryKey)&result_style=json&page_no=1&page_size=100&title=\(title)")!
        case .aladin(let isbn):
            return URL(string: "https://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=\(APIKey.aladinKey)&ItemIdType=ISBN13&ItemId=\(isbn)&Output=js&Cover=Big&Version=20131101&OptResult=ebookList,usedList,reviewList.js")!
        }
    }
}
