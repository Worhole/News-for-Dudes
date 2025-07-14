//
//  FetchNetworkNewsRepository.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import Combine

final class FetchNetworkNewsRepository: FetchNetworkNewsRepositoryProtocol {
    
    private let dataSource:NewsDataSourceProtocol
    
    init(dataSource: NewsDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func fetchNetworkNews(category:NewsCategory) -> AnyPublisher<[NetworkNews],any Error> {
        dataSource.fetchNetworkNews(category: category)
    }

}
