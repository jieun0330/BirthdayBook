//
//  NumberFormatManager.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/7/24.
//

import Foundation

final class DateFormatManager {
    
    static let shared = DateFormatManager()
    
    private init() { }
    
    let dateFormatter = DateFormatter()
    
    func calenderString(date: Date) -> String {
        dateFormatter.dateFormat = "MMdd"
        return dateFormatter.string(from: date)
    }
    
    func birthdayLabel(date: Date) -> String {
        dateFormatter.dateFormat = "M월 d일"
        return dateFormatter.string(from: date)
    }
    
    func stringToDate(date: String) -> String {
        // 2021-12-15(String)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // String -> Date
        let convertToDate = dateFormatter.date(from: date)
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "M월 d일"
        return myDateFormatter.string(from: convertToDate!)
    }
}
