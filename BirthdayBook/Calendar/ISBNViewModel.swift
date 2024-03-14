//
//  CalendarViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import Foundation

final class CalendarViewModel {
    
    var inputDate = Observable("")
    var inputISBN = Observable("")
    
    var outputLibraryBookAPIResult: Observable<[Doc]> = Observable([])
    var outputAladinAPIResult: Observable<[Item]> = Observable([])
    
    init() {
        self.inputDate.bind { value in
            APIManager.shared.dateLibraryCall(api: .dateLibrary(date: value)) { data in
                self.outputLibraryBookAPIResult.value = data
            }
        }
        
        self.inputISBN.bind { ISBN in
            APIManager.shared.aladinBookcallRequest(api: .aladin(isbn: ISBN)) { data in
                self.outputAladinAPIResult.value = data
            }
        }
    }
}
