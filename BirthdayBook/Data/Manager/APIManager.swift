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
    
    var bookImageArray: [Doc] = []
    var bookISBNArray: [String] = []
    
    func nationalLibraryCallRequest(api: BookAPI, completionHandler: @escaping ([String]) -> Void) {
        
        AF
            .request(api.url)
            .responseDecodable(of: NationalLibrary.self) { response in
                switch response.result {
                case .success(let success):
                    //                    print("success")
                    
                    // 이미지가 있을 경우
                    //                    for image in success.docs {
                    //                        if image.titleURL.count != 0 {
                    //                            self.bookImageArray.append(image)
                    //                        }
                    //                    }
                    
                    //                    completionHandler(self.bookImageArray)
                    
                    // ISBN만 가져오기
                    for isbn in success.docs {
                        self.bookISBNArray.append(isbn.eaIsbn)
                    }
                    
                    completionHandler(self.bookISBNArray)
                    
                case .failure(let failure):
                    print("failure")
                }
            }
    }
    
    func aladinCallRequest(api: BookAPI, completionHandler: @escaping ([Item]) -> Void) {
        
        AF
            .request(api.url)
            .responseDecodable(of: Aladin.self) { response in
                switch response.result {
                case .success(let success):
                    print("success")
                    completionHandler(success.item)
                case .failure(let failure):
                    print("failure")
                }
            }
    }
}
