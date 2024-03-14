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
    
    func dateLibraryCall(api: BookAPI, completionHandler: @escaping ([Doc]) -> Void) {
        
        AF
            .request(api.url)
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
    
    func isbnLibraryCall(api: BookAPI, completionHandler: @escaping ([Doc]) -> Void) {
        AF
            .request(api.url)
            .responseDecodable(of: NationalLibrary.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                    completionHandler(success.docs)
                case .failure(let failure):
                    print(failure)
                }
            }
    }
    
    func aladinBookcallRequest(api: BookAPI, completionHandler: @escaping ([Item]) -> Void) {
        
        AF
            .request(api.url)
            .responseDecodable(of: Aladin.self) { response in
                switch response.result {
                case .success(let success):
                    print("success")
                    completionHandler(success.item)
                case .failure(let failure):
                    print(failure)
                }
            }
    }
}
