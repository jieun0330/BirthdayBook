//
//  RealmData.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/11/24.
//

import Foundation
import RealmSwift

final class BookRealm: Object, BookDataProtocol {
    
    @Persisted(primaryKey: true)var title: String
    @Persisted var author: String
    @Persisted var cover: String
    @Persisted var isbn: String
    @Persisted var bookDescription: String
    
    convenience init(title: String, author: String, imgURL: String, isbn: String, bookDescription: String) {
        self.init()
        self.title = title
        self.author = author
        self.cover = imgURL
        self.isbn = isbn
        self.bookDescription = bookDescription
    }
}
