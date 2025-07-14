//
//  GetNewsRepository.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-13.
//

import Foundation

class NewsDetailRepository:NewsDetailRepositoryProtocol{
 
    private let dataSource:NewsDetailDataSourceProtocol
    
    init(dataSource: NewsDetailDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func deleteNews() {
        dataSource.deleteNews()
    }
    
    func saveNews() {
        dataSource.saveNews()
    }

    func getNews(completion: @escaping (Result<NewsDetailModel, any Error>) -> Void) {
        dataSource.getNews(completion: completion)
    }
    
    func isNewsSaved() -> Bool {
        dataSource.isNewsSaved()
    }
}
