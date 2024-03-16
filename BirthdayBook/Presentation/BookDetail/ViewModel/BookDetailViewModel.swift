//
//  DescriptionViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/14/24.
//

import Foundation

final class BookDetailViewModel {
    
//    var inputISBN = Observable("")
    var inputTitle = Observable("")

//    var outputAladinAPIResult: Observable<[Item]> = Observable([])
    var outputAladin2: Observable<[Item]> = Observable([])
    
    init() {
//        self.inputISBN.bind { ISBN in
//            APIManager.shared.aladinCallRequest(api: .isbnAladin(isbn: ISBN)) { data in
//                self.outputAladinAPIResult.value = data
//            }
//        }
        
        self.inputTitle.bind { bookTitle in
            APIManager.shared.aladinCallRequest(api: .titleAladin(query: bookTitle)) { data in
                self.outputAladin2.value = data
            }
        }
        
    }
}
