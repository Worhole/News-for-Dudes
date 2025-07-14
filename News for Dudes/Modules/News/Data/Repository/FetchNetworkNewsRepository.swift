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
    
    func fetchNetworkNews(category: NewsCategory, completion: @escaping (Result<[NetworkNews], any Error>) -> Void) {
        dataSource.fetchNetworkNews(category: category, completion: completion)
    }

}
