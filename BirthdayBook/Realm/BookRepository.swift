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
    
}
