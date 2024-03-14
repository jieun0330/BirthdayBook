//
//  RealmData.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/11/24.
//

import Foundation
import RealmSwift

final class BookRealm: Object {
    
    @Persisted(primaryKey: true)var bookTitle: String
    @Persisted var bookImgURL: String
    
    convenience init(bookTitle: String, bookImgURL: String) {
        self.init()
        self.bookTitle = bookTitle
        self.bookImgURL = bookImgURL
    }
}