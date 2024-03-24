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
            
            APIManager.shared.nationalLibraryCallRequest(api: .dateLibrary(date: value)) {
                [weak self] bookISBNArray, error in
                guard let self else { return }
                
                // Indicator stop animating
                self.inputIndicatorTrigger.value = false
                
                if let error = error {
                    print(error)
                } else {
                    guard let bookISBNArray else { return }
                    
                    print("1", bookISBNArray)
                    self.outputNationalLibraryAPIResult = bookISBNArray
                    self.inputISBNTrigger.value = ()
                }
            }
        }
        
        self.inputISBNTrigger.bind { [weak self] _ in
            guard let self else { return }
            for i in self.outputNationalLibraryAPIResult.prefix(5) {
                APIManager.shared.aladinCallRequest(api: .isbnAladin(isbn: i)) {
                    [weak self] bookItem, error in
                    print("2", i)
                    guard let self else { return }
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
    deinit {
        print(self)
    }
}
