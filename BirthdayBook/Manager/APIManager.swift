//
//  APIManager.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import Foundation
import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func callRequest(date: String, completionHandler: @escaping (Book) -> Void) {

        let key = APIKey.key

        let url = "https://www.nl.go.kr/seoji/SearchApi.do?cert_key=\(key)&result_style=json&page_no=1&page_size=10&start_publish_date=2023\(date)&end_publish_date=2023\(date)"
        
        AF
            .request(url)
            .responseDecodable(of: Book.self) { response in
            switch response.result {
            case .success(let success):
                print("success")
                completionHandler(success)
            case .failure(let failure):
                dump(failure)
            }
        }
    }
    
}
