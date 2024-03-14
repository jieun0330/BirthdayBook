//
//  CalendarViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import Foundation

final class CalendarViewModel {
    
    var inputDate = Observable("")
    
    var outputNationalLibraryAPIResult: Observable<[Doc]> = Observable([])
    
    init() {
        self.inputDate.bind { value in
            APIManager.shared.nationalLibraryCallRequest(api: .dateLibrary(date: value)) { data in
                self.outputNationalLibraryAPIResult.value = data
            }
        }
    }
}
