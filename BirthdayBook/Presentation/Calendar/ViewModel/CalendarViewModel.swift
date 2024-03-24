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
    var outputErrorMessage = Observable("")
    
    init() {
        
        self.inputDate.bind { bookDate in
            // Indicator Start animating
            self.inputIndicatorTrigger.value = true
            
            APIManager.shared.nationalLibraryCallRequest(api: .dateLibrary(date: bookDate)) { result in
                
                // Indicator stop animating
                self.inputIndicatorTrigger.value = false
                
                switch result {
                case .success(let success):
                    for isbn in success.docs {
                        if !isbn.isbn.isEmpty {
                            self.outputNationalLibraryAPIResult.append(isbn.isbn)
                        }
                    }
                    self.inputISBNTrigger.value = ()
                case .failure(let failure):
                    
                    if !failure.isResponseSerializationError {
                        self.outputErrorMessage.value = "잠시 후 다시 시도해주세요"
                    }
                }
            }
        }
        
        self.inputISBNTrigger.bind { _ in
            for i in self.outputNationalLibraryAPIResult.prefix(15) {
                APIManager.shared.aladinCallRequest(api: .isbnAladin(isbn: i)) { result in
                    switch result {
                    case .success(let success):
                        self.outputAladinAPIResult.value.append(contentsOf: success.item)
                    case .failure(let failure):
                        if !failure.isResponseSerializationError {
                            self.outputErrorMessage.value = "잠시 후 다시 시도해주세요"
                        }
                    }
                }
                if self.outputNationalLibraryAPIResult.count > 15 {
                    self.outputNationalLibraryAPIResult.removeSubrange(0...14)
                } else {
                    self.outputNationalLibraryAPIResult.removeAll()
                }
            }
        }
    }
    deinit {
        print(self)
    }
}
