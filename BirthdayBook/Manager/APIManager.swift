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
            .responseDecodable(of: NationalLibrary.self) { response in
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
    
    func aladinBookcallRequest(isbn: String, completionHandler: @escaping (Aladin) -> Void) {
        
        let apiKey = APIKey.aladinKey
        let url = "https://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=\(apiKey)&ItemIdType=ISBN13&ItemId=\(isbn)&Output=js&Version=20131101&OptResult=ebookList,usedList,reviewList.js"
        
        AF
            .request(url)
            .responseDecodable(of: Aladin.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                    completionHandler(success)
                case .failure(let failure):
                    print(failure)
                }
            }
    }
}
