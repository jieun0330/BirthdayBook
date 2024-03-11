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
    
    var emptyArray: [String] = []
    
    func callRequest(date: String, completionHandler: @escaping (LibraryBook) -> Void) {
        
        let key = APIKey.libraryKey
        
        let url = "https://www.nl.go.kr/seoji/SearchApi.do?cert_key=\(key)&result_style=json&page_no=1&page_size=100&start_publish_date=2023\(date)&end_publish_date=2023\(date)"
        
        AF
            .request(url)
            .responseDecodable(of: LibraryBook.self) { response in
                switch response.result {
                case .success(let success):
                    print("success")
                    
                    // 이미지가 있을 경우
//                    for i in success.docs {
//                        if i.titleURL.count != 0 {
//                            self.emptyArray.append(i.titleURL)
//                            print("self.emptyArray", self.emptyArray)
//                            if self.emptyArray.count == 10 {
//                                break
//                            }
//                            print("self.emptyArray", self.emptyArray)
//                        }
//                    }
                    
                    completionHandler(success)
                    
                case .failure(let failure):
                    dump(failure)
                }
            }
    }
    
    //    func naverRequest(query: String, completionHandler: @escaping ([Item]) -> Void) {
    //
    //        let header: HTTPHeaders = [
    //            "X-Naver-Client-Id": APIKey.naverClientID,
    //            "X-Naver-Client-Secret": APIKey.naverSecret
    //        ]
    //
    //        let url = "https://openapi.naver.com/v1/search/book?query=\(query)&display=100&start=1"
    //
    //        AF
    //            .request(url, headers: header)
    //            .responseDecodable(of: [Item].self) { response in
    //            switch response.result {
    //            case .success(let success):
    //                print(success)
    //                completionHandler(success)
    //            case .failure(let failure):
    //                print(failure)
    //            }
    //        }
    //    }
}