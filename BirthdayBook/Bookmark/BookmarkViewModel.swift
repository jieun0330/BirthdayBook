//
//  BookmarkViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/13/24.
//

import Foundation

final class BookmarkViewModel {
    
    var inputBookISBN = Observable("")
    
    var outputBookInfo: Observable<[Item]> = Observable([])
    
    init() {
        
        self.inputBookISBN.bind { ISBN in
            APIManager.shared.aladinBookcallRequest(isbn: ISBN) { data in
                self.outputBookInfo.value = data
            }
        }
    }
}
