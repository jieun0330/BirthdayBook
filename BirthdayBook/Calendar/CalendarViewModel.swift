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
//            print("value", value)
            APIManager.shared.callRequest(date: value) { data in
//                print("data", data.totalCount)
                self.outputBookAPIResult.value = data.docs
            }
        }
    }
}
