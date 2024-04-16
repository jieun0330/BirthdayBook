//
//  MoneyFormatManager.swift
//  BirthdayBook
//
//  Created by 박지은 on 4/16/24.
//

import Foundation

final class NumberFormatManager {
    static let shared = NumberFormatManager()
    
    private init() { }
    
    let numberFormatter = NumberFormatter()
    
    func numberFormat(number: Int) -> String {
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(for: number)!
    }
}
