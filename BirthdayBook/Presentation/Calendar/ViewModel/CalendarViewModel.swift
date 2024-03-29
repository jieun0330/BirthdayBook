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
        
        self.inputDate.bind { [weak self] bookDate in
            guard let self else { return }
            
            // Indicator Start animating
            self.inputIndicatorTrigger.value = true
            
            APIManager.shared.nationalLibraryCallRequest(api: .dateLibrary(date: bookDate)) {
                [weak self] result in
                guard let self else { return }
                
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
                    // print("ISBN 갯수 : \(self.outputNationalLibraryAPIResult.count)")
                case .failure(let failure):
                    
                    if !failure.isResponseSerializationError {
                        self.outputErrorMessage.value = "잠시 후 다시 시도해주세요"
                    }
                }
            }
        }
        
        self.inputISBNTrigger.bind { [weak self] _ in
            guard let self else { return }
            
            let isbnSlice = self.outputNationalLibraryAPIResult.prefix(15)
            // 2번 문제
            // 메모리 공부하기
            var aladinSuccessItem: [Item] = []
            var failureCount = 0
            
            for i in isbnSlice {
                APIManager.shared.aladinCallRequest(api: .isbnAladin(isbn: i)) {
                    [weak self] result in
                    guard let self else { return }
                    
                    switch result {
                    case .success(let success):
                        
                        aladinSuccessItem.append(contentsOf: success.item)
                        
                        if aladinSuccessItem.count + failureCount == isbnSlice.count {
                            // 1번 문제
                            // outputAladinAPIResult가 처음 15개 API결과가 들어온 후에
                            // 그 다음 네트워크 결과가 덮어씌워지지 않고 추가될 수 있도록 append한다
                            self.outputAladinAPIResult.value.append(contentsOf: aladinSuccessItem)
                        }
                        
                    case .failure(let failure):
                        failureCount += 1
                        if !failure.isResponseSerializationError {
                            self.outputErrorMessage.value = "잠시 후 다시 시도해주세요"
                        }
                        print(failure)
                    }
                    // print("성공 : \(aladinSuccessItem.count) 실패 : \(failureCount)")
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
