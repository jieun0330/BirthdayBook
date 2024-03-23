//
//  BookDetailViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/22/24.
//

import Foundation

final class BookDetailViewModel {
    
    private let repository = BookRepository()
//    private var bookRealm: BookRealm?
    var test: String?
    var data: BookDataProtocol?
    
    func configure(data: BookDataProtocol) {
        // 데이터는 받아와야하잖아
//        self.test = data.title
        self.data = data
        
//        self.bookRealm = BookRealm(title: data.title,
//                                     author: data.author,
//                                     imgURL: data.cover,
//                                     isbn: data.isbn,
//                                     bookDescription: data.bookDescription,
//                                     itemId: data.itemId)
        
    }
    
    func configure(dataID: String) {
        self.test = dataID
    }
    
    func isBookMarked() -> Bool {
        
        guard let test else { return true }
        return !repository.fetchItemTitle(bookTitle: test).isEmpty
//        return !repository.fetchItemTitle(bookTitle: title).isEmpty
    }
    
    func bookMarkButtonClicked() {
        
        
//        guard let test else { return }
//        guard let spotify = repository.fetchItemTitle(bookTitle: test).first else { return }
        
                
//        if let spotify = repository.fetchItemTitle(bookTitle: test).first {
            // 렘에 있어
            
//            print("2", spotify)
//        } else {
            // 렘에 없어
            
//            repository.
//            repository.createRealm()
//            print("3")
//        }
        
        
//        print("1", self.test)
//        guard let bookRealm else { return }
//        
        if isBookMarked() {
            guard let test else { return }
            let seven = repository.fetchItemTitle(bookTitle: test)
            
            guard let stacey = seven.first else { return }
            repository.deleteItem(stacey)


//
//            let lauv = repository.fetchItemTitle(bookTitle: test)
//            repository.createRealm(lauv.first!)
            
//            repository.fetchItemTitle(bookTitle: bookRealm.title)
//            
//            repository.deleteItem(bookRealm)
        } else {
            
            
            guard let data else { return }
            print("1", data)
            repository.createRealm(BookRealm(title: data.title,
                                             author: data.author,
                                             imgURL: data.cover,
                                             isbn: data.isbn,
                                             bookDescription: data.bookDescription,
                                             itemId: data.itemId))
            
//            repository.
//            repository.createRealm(bookRealm)
        }
    }
}
