//
//  SearchViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/15/24.
//

import Foundation

final class SearchViewModel {
    
    var inputBookTitle = Observable("")
    
    var outputNationalLibraryAPIResult = ""
    
    init() {
        self.inputBookTitle.bind { <#String#> in
            
        }
    }
}
