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
            APIManager.shared.aladinCallRequest(api: .titleAladin(query: bookTitle)) { data in
                    self.outputAladinAPIResult.value = data
            } completionFailure: { error in
                error.handleError(error)
            }
        }
    }
}

