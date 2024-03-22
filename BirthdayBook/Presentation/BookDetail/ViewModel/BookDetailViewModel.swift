//
//  BookDetailViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/22/24.
//

import Foundation

final class BookDetailViewModel {
    
    private let repository = BookRepository()
    private var bookRealm: BookRealm?
    
    func configure(data: BookDataProtocol) {
        let newBookRealm = BookRealm(title: data.title,
                                     author: data.author,
                                     imgURL: data.cover,
                                     isbn: data.isbn,
                                     bookDescription: data.bookDescription,
                                     itemId: data.itemId)
        
        self.bookRealm = newBookRealm
    }
    
    func isBookMarked() -> Bool {
        guard let title = bookRealm?.title else { return false }
        return !repository.fetchItemTitle(bookTitle: title).isEmpty
    }
    
    func bookMarkButtonClicked() {
        guard let bookRealm else { return }
        
        if isBookMarked() {
            repository.deleteItem(bookRealm)
        } else {
            repository.createRealm(bookRealm)
        }
    }
}
