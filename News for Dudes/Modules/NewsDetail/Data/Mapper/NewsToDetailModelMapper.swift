//
//  NewsToDetailModuleMapper.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Foundation

extension NetworkNews {
    func toDisplayModel() -> NewsDetailModel {
        return NewsDetailModel(source: self.source.name,
                               author: self.author,
                               title: self.title,
                               description: self.description,
                               urlToImage: self.urlToImage,
                               publishedAt: self.publishedAt,
                               content: self.content)
    }
}

extension Bookmarks {
    func toDisplayModel() -> NewsDetailModel {
        return NewsDetailModel(source: self.source,
                               author: self.author,
                               title: self.title,
                               description: self.newsDescription,
                               urlToImage: self.urlToImage,
                               publishedAt: self.publishedAt,
                               content: self.content)
    }
}
