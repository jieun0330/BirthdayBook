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
    
    var bookISBNArray: [String] = []
    
    func nationalLibraryCallRequest(api: BookAPI,
                                    completionSuccess: @escaping ([String]) -> Void,
                                    completionFailure: @escaping (AFError) -> Void) {
        
        AF
            .request(api.url)
            .responseDecodable(of: NationalLibrary.self) { response in
                switch response.result {
                case .success(let success):
                    // ISBN만 가져오기
                    for isbn in success.docs {
                        self.bookISBNArray.append(isbn.eaIsbn)
                    }
                    completionSuccess(self.bookISBNArray)
                case .failure(let failure):
                    completionFailure(failure)
                }
            }
    }
    
    func aladinCallRequest(api: BookAPI,
                           completionSuccess: @escaping ([Item]) -> Void,
                           completionFailure: @escaping (AFError) -> Void) {
        
        AF
            .request(api.url)
            .responseDecodable(of: Aladin.self) { response in
                switch response.result {
                case .success(let success):
                    completionSuccess(success.item)
                case .failure(let failure):
                    completionFailure(failure)
                }
            }
    }
}
