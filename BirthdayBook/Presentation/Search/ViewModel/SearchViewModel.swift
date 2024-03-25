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
        
        self.inputBookTitle.bind { [weak self] bookTitle in
            guard let self else { return }
            APIManager.shared.aladinCallRequest(api: .titleAladin(query: bookTitle)) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let success):
                    self.outputAladinAPIResult.value = success.item
                case .failure(let failure):
                    print(failure)
                }
            }
        }
        
        self.inputBestSeller.bind { [weak self] _ in
            guard let self else { return }
            APIManager.shared.aladinCallRequest(api: .bestSeller) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let success):
                    self.outputAladinAPIResult.value = success.item
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}

