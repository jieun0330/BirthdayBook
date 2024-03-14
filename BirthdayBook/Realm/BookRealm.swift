//
//  RealmData.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/11/24.
//

import Foundation
import RealmSwift

final class BookRealm: Object {
    
    @Persisted(primaryKey: true)var title: String
    @Persisted var imgURL: String
    @Persisted var isbn: String
    @Persisted var bookDescription: String
    
    convenience init(title: String, imgURL: String, isbn: String, bookDescription: String) {
        self.init()
        self.title = title
        self.imgURL = imgURL
        self.isbn = isbn
        self.bookDescription = bookDescription
    }
}
