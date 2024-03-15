//
//  SearchViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/15/24.
//

import Foundation

final class SearchViewModel {
    
    var inputBookTitle = Observable("")
    
    var outputNationalLibraryAPIResult: Observable<[Doc]> = Observable([])
    
    init() {
//        self.inputBookTitle.bind { bookTitle in
//            APIManager.shared.nationalLibraryCallRequest(api: .titleLbirary(title: bookTitle)) { data in
//                print("data", data)
//                self.outputNationalLibraryAPIResult.value = data
//            }
//        }
    }
}
