//
//  API.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/13/24.
//

import Foundation

enum BookAPI {
    case dateLibrary(date: String)
    case isbnAladin(isbn: String)
    case titleAladin(query: String)
    case bestSeller
    
    var url: URL {
        switch self {
        case .dateLibrary(let date):
            return URL(string: "https://www.nl.go.kr/seoji/SearchApi.do?cert_key=\(APIKey.libraryKey)&result_style=json&page_no=1&page_size=20&start_publish_date=2023\(date)&end_publish_date=2023\(date)")!
        case .isbnAladin(let isbn):
            return URL(string: "https://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=\(APIKey.aladinKey)&ItemIdType=ISBN13&ItemId=\(isbn)&Output=js&Cover=Big&Version=20131101&OptResult=ebookList,usedList,reviewList.js")!
        case .titleAladin(let query):
            return URL(string: "https://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=\(APIKey.aladinKey)&Output=js&Cover=Big&Query=\(query)&MaxResults=10&Start=1&Version=20131101")!
        case .bestSeller:
            return URL(string: "https://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=\(APIKey.aladinKey)&Output=js&Cover=Big&MaxResults=10&Start=1&QueryType=Bestseller&SearchTarget=Book&Version=20131101")!
        }
    }
}
