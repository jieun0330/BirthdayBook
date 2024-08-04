//
//  BookRepository.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/11/24.
//

import Foundation
import RealmSwift

final class BookRepository {
    
    private let realm = try! Realm()
    
    // Create
    func createRealm(_ data: BookRealm) {
        do {
            try realm.write {
                realm.add(data)
                print(realm.configuration.fileURL)
            }
        } catch {
            print(error)
        }
    }
    
    // Read
    func fetchAllItem() -> [BookRealm] {
        let result = realm.objects(BookRealm.self)
        return Array(result)
    }
    
    func fetchItemTitle(bookTitle: String) -> Results<BookRealm> {
        return realm.objects(BookRealm.self).where {
            $0.title == bookTitle
        }
    }
    
    // Delete
    func deleteItem(_ data: BookRealm) {
        
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print(error)
        }
    }
}
