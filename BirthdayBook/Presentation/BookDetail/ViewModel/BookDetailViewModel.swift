//
//  DescriptionViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/14/24.
//

import Foundation

final class BookDetailViewModel {
    
    var inputTitle = Observable("")
    
    var outputAladinAPIResult: Observable<[Item]> = Observable([])
    
    init() {
        self.inputTitle.bind { bookTitle in
            APIManager.shared.aladinCallRequest(api: .titleAladin(query: bookTitle)) { data in
                self.outputAladinAPIResult.value = data
            }
        }
    }
}
