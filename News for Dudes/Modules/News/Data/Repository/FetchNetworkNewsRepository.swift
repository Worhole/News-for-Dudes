//
//  FetchNetworkNewsRepository.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import Combine

final class FetchNetworkNewsRepository: FetchNetworkNewsRepositoryProtocol {
    
    private let fetchNetworkNewsDataSource:FetchNetworkNewsDataSourceProtocol
    
    init(fetchNetworkNewsDataSource: FetchNetworkNewsDataSourceProtocol) {
        self.fetchNetworkNewsDataSource = fetchNetworkNewsDataSource
    }
    
    func fetchNetworkNews() -> AnyPublisher<[NetworkNews],any Error> {
        fetchNetworkNewsDataSource.getNetworkNews()
    }

}
