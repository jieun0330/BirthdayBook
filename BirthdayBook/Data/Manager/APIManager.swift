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
    
    func nationalLibraryCallRequest(api: BookAPI,
                                    completionHandler: @escaping (Result<NationalLibrary, AFError>) -> Void) {
        
        AF
            .request(api.url)
            .responseDecodable(of: NationalLibrary.self) { response in
                completionHandler(response.result)
            }
    }
    
    func aladinCallRequest(api: BookAPI,
                           completionHandler: @escaping (Result<Aladin, AFError>) -> Void) {
        
        AF
            .request(api.url)
            .responseDecodable(of: Aladin.self) { response in
                completionHandler(response.result)
            }
    }
}
