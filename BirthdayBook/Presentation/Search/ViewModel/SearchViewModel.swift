//
//  SearchViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/15/24.
//

import Foundation

final class SearchViewModel {
    
    var inputBookTitle = Observable("")
    var inputBestSeller: Observable<Void?> = Observable(nil)
    
    var outputAladinAPIResult: Observable<[Item]> = Observable([])
    
    init() {
        
        self.inputBookTitle.bind { bookTitle in
            APIManager.shared.aladinCallRequest(api: .titleAladin(query: bookTitle)) { [weak self] bookItem, error in
                guard let self else { return }
                
                if let error = error {
                    print(error)
                } else {
                    guard let bookItem else { return }
                    self.outputAladinAPIResult.value = bookItem
                }
            }
        }
        
        self.inputBestSeller.bind { _ in
            APIManager.shared.aladinCallRequest(api: .bestSeller) { [weak self] bestSellerBook, error in
                guard let self else { return }
                
                if let error = error {
                    print(error)
                } else {
                    guard let bestSellerBook else { return }
                    self.outputAladinAPIResult.value = bestSellerBook
                }
            }
        }
    }
}

