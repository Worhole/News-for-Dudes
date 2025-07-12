//
//  NewsCategory.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-12.
//

import Foundation

enum NewsCategory {
    case general
    case entertainment
    case business
    case health
    case science
    case sports
    case technology
}

struct NewsURLBuilder {
    
    var newsCategory: NewsCategory
    
    var url: URL? {
        let apiKey = "3d09b62d49ba400586ed2a3b0a43380a"
        var category = ""
        
        switch newsCategory {
        case .general:
            category = "general"
        case .entertainment:
            category = "entertainment"
        case .business:
            category = "business"
        case .health:
            category = "health"
        case .science:
            category = "science"
        case .sports:
            category = "sports"
        case .technology:
            category = "technology"
        }
        
        let urlStr = "https://newsapi.org/v2/top-headlines?category=\(category)&apiKey=\(apiKey)"
        return URL(string: urlStr)
    }
}

