//
//  FetchNetworkNewsDataSource.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import Combine

protocol NewsDataSourceProtocol {
    func fetchNetworkNews(category:NewsCategory) -> AnyPublisher<[NetworkNews],any Error>
}
