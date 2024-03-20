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
                    completionHandler(nil, failure)
                    let alert = UIAlertController(title: "잠시 후 다시 시도해주세요", message: "?", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(okButton)
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
                    if !failure.isResponseSerializationError {
                        completionHandler(nil, failure)
                    }
                }
            }
    }
}
