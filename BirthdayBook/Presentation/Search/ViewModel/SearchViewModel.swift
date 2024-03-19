//
//  SearchViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/15/24.
//

import Foundation

final class SearchViewModel {
    
    var inputBookTitle = Observable("")
    
    var outputAladinAPIResult: Observable<[Item]> = Observable([])
    
    init() {
        
        self.inputBookTitle.bind { bookTitle in
            APIManager.shared.aladinCallRequest(api: .titleAladin(query: bookTitle)) { bookItem, error in
                
                if let error = error {
                    print("문제가 있는 상황")
                } else {
                    guard let bookItem else { return }
                    self.outputAladinAPIResult.value = bookItem
                }
            }
        }
    }
}

