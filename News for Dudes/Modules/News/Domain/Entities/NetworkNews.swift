//
//  News.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import Foundation

struct Articles:Codable, Hashable {
    let articles:[NetworkNews]
}

struct NetworkNews:Codable, Hashable {
    let source:Sourse
    let author:String?
    let title:String?
    let description:String?
    let urlToImage: String?
    let publishedAt:String?
    let content:String?
}


struct Sourse:Codable, Hashable {
    let id:String?
    let name:String?
}
