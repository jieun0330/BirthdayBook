//
//  KingFisherCache.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/20/24.
//

import Foundation
import Kingfisher

final class KingfisherCache {
    
    static let shared = KingfisherCache()
    
    func checkCurrentCacheSize() {
        ImageCache.default.calculateDiskStorageSize { result in
            switch result {
            case .success(let size):
                print("disk cache size = \(Double(size) / 1024 / 1024)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func removeCache() {
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache { print("done clearDiskCache") }
        
        ImageCache.default.cleanExpiredMemoryCache()
        ImageCache.default.cleanExpiredDiskCache { print("done cleanExpriedDiskCache") }
    }
}
