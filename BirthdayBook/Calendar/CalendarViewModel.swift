//
//  CalendarViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import Foundation

final class CalendarViewModel {
    
    var inpuDate = Observable("")
    
    var outputBookAPIResult: Observable<[Doc]> = Observable([])
    
    init() {
        self.inpuDate.bind { value in
            
            APIManager.shared.callRequest(date: value) { data in
                self.outputBookAPIResult.value = data.docs
            }
        }
    }
}
