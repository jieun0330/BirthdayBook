//
//  SettingEnum.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/21/24.
//

import Foundation

enum SettingEnum: CaseIterable {
    case question
    case privacy
    case version
    
    var setting: String {
        switch self {
        case .question:
            return "문의하기"
        case .privacy:
            return "개인정보처리방침"
        case .version:
            return "버전 정보"
        }
    }
    
    var url: URL? {
        switch self {
        case .question:
            return URL(string: "https://forms.gle/bG8GikriUHdidgVu6")!
        case .privacy:
            return URL(string: "https://0330cyndi.notion.site/2f187cda6b9c4a978d1035061f5515b4")!
        case .version:
            return nil
        }
    }
}
