//
//  WebViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/16/24.
//

import Foundation

final class WebViewModel {
    
    var inputItemID = Observable(0)
    
    var outputURL: Observable<URL?> = Observable(URL(string: ""))
    
    init() {
        
        self.inputItemID.bind { id in
            let urlString = "https://www.aladin.co.kr/shop/wproduct.aspx?ItemId=\(id)&partner=openAPI&start=api"
            self.outputURL.value = URL(string: urlString)
        }
    }
}
