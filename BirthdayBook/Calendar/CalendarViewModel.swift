//
//  CalendarViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import Foundation

final class CalendarViewModel {
    
    var inputDate = Observable("")
    var inputBookTitle = Observable("")
    
    var outputLibraryBookAPIResult: Observable<[Doc]> = Observable([])
    var outputNaverAPIResult: Observable<Item>!
    
    init() {
        self.inputDate.bind { value in
            APIManager.shared.callRequest(date: value) { data in
                self.outputLibraryBookAPIResult.value = data
            }
        }
        
//        inputBookTitle.bind { bookTitle in
//            print("bookTitle", bookTitle)
//            APIManager.shared.naverRequest(query: bookTitle) { data in
//                print("data", data)
//            }
//        }
        
    }
}
