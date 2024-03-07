//
//  NumberFormatManager.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/7/24.
//

import Foundation

final class NumberFormatManager {
    
    static let shared = NumberFormatManager()
    
    private init() { }
    
    private let dateFormatter = DateFormatter()
    
    func calenderFormat() {
        dateFormatter.dateFormat = "yyyy MMMM dd hh"
    }
    
}
