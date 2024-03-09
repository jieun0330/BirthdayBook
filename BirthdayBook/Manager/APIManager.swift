//
//  APIManager.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import Foundation

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func callRequest(date: String) {

        let key = APIKey.key

        let url = "https://www.nl.go.kr/seoji/SearchApi.do?cert_key=\(key)&result_style=json&page_no=1&page_size=10&start_publish_date=\(date)&end_publish_date=\(date)"
    }
    
}
