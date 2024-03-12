//
//  CalendarViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import Foundation

final class CalendarViewModel {
    
    var inputDate = Observable("")
    
    var outputLibraryBookAPIResult: Observable<[Doc]> = Observable([])
    
    init() {
        self.inputDate.bind { value in
            APIManager.shared.callRequest(date: value) { data in
                self.outputLibraryBookAPIResult.value = data
            }
        }
    }
}
