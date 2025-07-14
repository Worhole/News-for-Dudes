//
//  SaveNewsDataSourceProtocol.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Foundation

protocol NewsDetailDataSourceProtocol{
    func deleteNews()
    func getNews(completion: @escaping (Result<NewsDetailModel, Error>) -> Void)
    func saveNews()
    func isNewsSaved()->Bool
}
