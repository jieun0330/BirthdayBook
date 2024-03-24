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
    
    func nationalLibraryCallRequest(api: BookAPI,
                                    completionHandler: @escaping (Result<NationalLibrary, AFError>) -> Void) {
        
        AF
            .request(api.url)
            .responseDecodable(of: NationalLibrary.self) { [weak self] response in
                guard let self else { return }
                
                completionHandler(response.result)
            }
    }
    
    func aladinCallRequest(api: BookAPI,
                           completionHandler: @escaping (Result<Aladin, AFError>) -> Void) {
        
        AF
            .request(api.url)
            .responseDecodable(of: Aladin.self) { [weak self] response in
                guard let self else { return }
                
                completionHandler(response.result)
            }
    }
}
