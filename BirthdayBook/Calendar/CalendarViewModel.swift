//
//  CalendarViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import Foundation

final class CalendarViewModel {
    
    var inpuDate = Observable("")
    
    var outputLibraryBookAPIResult: Observable<[Doc]> = Observable([])
//    var outputNaverBookAPIResult: Observable<[Item]> = Observable([])
    
    init() {
        self.inpuDate.bind { value in
            APIManager.shared.callRequest(date: value) { data in
                self.outputLibraryBookAPIResult.value = data.docs
                
//                print("data", data.docs[0].title)
                
//                APIManager.shared.naverRequest(query: data.docs[0].title) { naverData in
//                    self.outputNaverBookAPIResult.value = naverData
//                    print("naverData", naverData)
//                }
            }
        }
    }
}
