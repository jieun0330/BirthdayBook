//
//  APIManager.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import UIKit
import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    var bookISBNArray: [String] = []
    var test: [Item] = []
    
    func nationalLibraryCallRequest(api: BookAPI, completionHandler: @escaping ([String]?, AFError?) -> Void) {
        
        AF
            .request(api.url)
            .responseDecodable(of: NationalLibrary.self) { response in
                switch response.result {
                case .success(let success):
                    // ISBN만 가져오기
                    for isbn in success.docs {
                        if !isbn.isbn.isEmpty {
                            self.bookISBNArray.append(isbn.isbn)
                        }
                    }
                    completionHandler(self.bookISBNArray, nil)
                case .failure(let failure):
                    print(failure)
                }
            }
    }
    
    func aladinCallRequest(api: BookAPI, completionHandler: @escaping ([Item]?, AFError?) -> Void) {
        
        AF
            .request(api.url)
            .responseDecodable(of: Aladin.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success.item, nil)
                case .failure(let failure):
                    completionHandler(nil, failure)
                    //                    print("failure")
                }
            }
    }
}
