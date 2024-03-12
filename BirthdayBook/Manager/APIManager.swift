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
    
    var emptyArray: [Doc] = []
    
    func callRequest(date: String, completionHandler: @escaping ([Doc]) -> Void) {
        
        let key = APIKey.libraryKey
        
        let url = "https://www.nl.go.kr/seoji/SearchApi.do?cert_key=\(key)&result_style=json&page_no=1&page_size=100&start_publish_date=2023\(date)&end_publish_date=2023\(date)"
        
        AF
            .request(url)
            .responseDecodable(of: LibraryBook.self) { response in
                switch response.result {
                case .success(let success):
                    print("success")
                    
                    // 이미지가 있을 경우
                    for image in success.docs {
                        if image.titleURL.count != 0 {
                            self.emptyArray.append(image)
                        }
                    }
                    completionHandler(self.emptyArray)
                    
                case .failure(let failure):
                    print(failure)
                }
            }
    }
    
//        func naverRequest(text: String, completionHandler: @escaping (NaverBook) -> Void) {
//            
//            let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            
//            let header: HTTPHeaders = [
//                "X-Naver-Client-Id": APIKey.naverClientID,
//                "X-Naver-Client-Secret": APIKey.naverSecret
//            ]
//    
//            let url = "https://openapi.naver.com/v1/search/book?query=\(query)&display=100&start=1"
//    
//            AF
//                .request(url, headers: header)
//                .responseDecodable(of: NaverBook.self) { response in
//                switch response.result {
//                case .success(let success):
//                    print("success")
//                    completionHandler(success)
//                case .failure(let failure):
//                    dump(failure)
//                }
//            }
//        }
    
    func daumBookcallRequest() {
        
        
        
    }
    
    
}
