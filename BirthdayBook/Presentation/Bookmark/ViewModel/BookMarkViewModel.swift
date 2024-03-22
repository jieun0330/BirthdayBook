//
//  BookMarkViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/22/24.
//

import Foundation

final class BookMarkViewModel {
    
    private var repository = BookRepository()
    
    func repositoryItemCount() -> Int {
        return repository.fetchAllItem().count
    }
    
    func repositoryEmpty() -> Bool {
        return repository.fetchAllItem().isEmpty
    }
    
    func repositoryFetch() -> [BookRealm] {
        return repository.fetchAllItem()
    }
}
