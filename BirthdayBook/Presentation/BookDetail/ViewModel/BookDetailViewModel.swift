//
//  DescriptionViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/14/24.
//

import Foundation

final class BookDetailViewModel {
    
    var inputISBN = Observable("")

    var outputAladinAPIResult: Observable<[Item]> = Observable([])
    
    init() {
        self.inputISBN.bind { ISBN in
            APIManager.shared.aladinCallRequest(api: .aladin(isbn: ISBN)) { data in
                self.outputAladinAPIResult.value = data
            }
        }
    }
}
