//
//  BookmarkViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/13/24.
//

import Foundation

final class BookmarkViewModel {
    
    var inputBookISBN = Observable("")
    
    var outputBookInfo: Observable<[Doc]> = Observable([])
    
    init() {
        
        self.inputBookISBN.bind { ISBN in
            APIManager.shared.isbnLibraryCall(api: .isbnLibrary(isbn: ISBN)) { data in
                self.outputBookInfo.value = data
            }
        }
    }
}
