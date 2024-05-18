//
//  BookDetailViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/22/24.
//

import Foundation

final class BookDetailViewModel {
    
    private let repository = BookRepository()
    private var bookTitle: String?
    private var data: BookDataProtocol?
    
    func configure(data: BookDataProtocol) {
        self.data = data
        self.bookTitle = data.title
    }
    
    func isBookMarked() -> Bool {
        guard let bookTitle else { return true }
        return !repository.fetchItemTitle(bookTitle: bookTitle).isEmpty
    }
    
    func bookMarkButtonClicked() {
        
        if isBookMarked() {
            guard let bookTitle else { return }
            let book = repository.fetchItemTitle(bookTitle: bookTitle)
            
            guard let book = book.first else { return }
            repository.deleteItem(book)
            
        } else {
            guard let data else { return }
            repository.createRealm(BookRealm(title: data.title,
                                             author: data.author,
                                             imgURL: data.cover,
                                             isbn: data.isbn,
                                             bookDescription: data.bookDescription,
                                             itemId: data.itemId))
        }
    }
}
