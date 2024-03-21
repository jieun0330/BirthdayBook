//
//  CalendarViewModel.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/9/24.
//

import Foundation

final class CalendarViewModel {
    
    var inputDate = Observable("")
    var inputISBNTrigger: Observable<Void?> = Observable(nil)
    var inputIndicatorTrigger = Observable(false)
    
    var outputNationalLibraryAPIResult: [String] = []
    var outputAladinAPIResult: Observable<[Item]> = Observable([])
    
    init() {
        self.inputDate.bind { value in
            
            // Indicator start animating
            self.inputIndicatorTrigger.value = true
            
            APIManager.shared.nationalLibraryCallRequest(api: .dateLibrary(date: value)) { bookISBNArray, error in
                
                // Indicator stop animating
                self.inputIndicatorTrigger.value = false
                
                if let error = error {
                    print(error)
                } else {
                    guard let bookISBNArray else { return }
                    self.outputNationalLibraryAPIResult = bookISBNArray
                    self.inputISBNTrigger.value = ()
                }
            }
        }
        
        self.inputISBNTrigger.bind { _ in
            for i in self.outputNationalLibraryAPIResult.prefix(5) {
                APIManager.shared.aladinCallRequest(api: .isbnAladin(isbn: i)) { bookItem, error in
                    if let error = error {
                        print(error)
                    } else {
                        guard let bookItem else { return }
                        self.outputAladinAPIResult.value.append(contentsOf: bookItem)
                    }
                }
            }
            if self.outputNationalLibraryAPIResult.count > 5 {
                self.outputNationalLibraryAPIResult.removeSubrange(0...4)
            } else {
                self.outputNationalLibraryAPIResult.removeAll()
            }
        }
    }
}
