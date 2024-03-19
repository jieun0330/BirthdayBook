//
//  CalendarViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import Foundation

final class CalendarViewModel {
    
    var inputDate = Observable("")
    
    var outputAladinAPIResult: Observable<[Item]> = Observable([])
    
    init() {
        self.inputDate.bind { value in
            APIManager.shared.nationalLibraryCallRequest(api: .dateLibrary(date: value)) { bookISBNArray, error in
                
                if let error = error {
                    print("문제가 있는 상황")
                } else {
                    guard let bookISBNArray else { return }
                    bookISBNArray.forEach({ isbn in
                        APIManager.shared.aladinCallRequest(api: .isbnAladin(isbn: isbn)) { bookItem, error in
                            if let error = error {
                                print("문제가 있는 상황")
                            } else {
                                guard let bookItem else { return }
                                for book in bookItem {
                                    self.outputAladinAPIResult.value.append(book)
                                }
                            }
                        }
                    })
                }
            }
        }
    }
}
