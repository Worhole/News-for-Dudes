//
//  GetNewsRepository.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-13.
//

import Foundation
import Combine

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

    func getNews() -> AnyPublisher<NewsDetailModel, any Error> {
        dataSource.getNews()
    }
    
    func isNewsSaved() -> Bool {
        dataSource.isNewsSaved()
    }
}
