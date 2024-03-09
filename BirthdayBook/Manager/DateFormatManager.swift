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
    
    func calenderString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMdd"
        
        return dateFormatter.string(from: date)
    }
}
