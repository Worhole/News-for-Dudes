//
//  NewsDetailData.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Foundation

struct NewsDetailViewData {
    let title: String
    let description: String
    let author: String
    let date: String
    let source: String
    let imageUrl: String?
    let content: String

    init(model: NewsDetailModel) {
        self.title = model.title ?? "No Title"
        self.description = model.description ?? "No Description"
        self.author = model.author ?? "Unknown Author"
        self.source = model.source ?? "Unknown Source"
        self.imageUrl = model.urlToImage
        self.content = model.content ?? ""
        
        self.date = newsDateFormatter.formatDate(model.publishedAt)
    }
}
