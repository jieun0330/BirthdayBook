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
            APIManager.shared.nationalLibraryCallRequest(api: .dateLibrary(date: value)) { data in
                data.forEach { isbn in
                    APIManager.shared.aladinCallRequest(api: .aladin(isbn: isbn)) { data in
                        for book in data {
                            self.outputAladinAPIResult.value.append(book)
                        }
                    }
                }
            }
        }
    }
}
