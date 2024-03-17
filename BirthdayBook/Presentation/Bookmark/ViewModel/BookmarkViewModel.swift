//
//  BookmarkViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/17/24.
//

import Foundation

final class BookmarkViewModel {
    
    private let repository = BookRepository()
    
    var outputRepositoryCount = Observable(0)
    var outputBookRealm: Observable<[BookRealm]> = Observable([])
    
    init() {
        
        self.outputRepositoryCount.value = repository.fetchAllItem().count
        self.outputBookRealm.value = repository.fetchAllItem()
    }
}
