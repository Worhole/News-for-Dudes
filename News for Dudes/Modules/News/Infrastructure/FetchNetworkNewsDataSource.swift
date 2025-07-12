//
//  FetchNetworkNewsDataSource.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import Combine
import Foundation

class FetchNetworkNewsDataSource:FetchNetworkNewsDataSourceProtocol {
    func getNetworkNews(category: NewsCategory) -> AnyPublisher<[NetworkNews], any Error> {
        guard let url = NewsURLBuilder(newsCategory: category).url else {
            return Fail(error: URLError.badURL as! Error).eraseToAnyPublisher()
        }
        
        let dataPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Articles.self, decoder: JSONDecoder())
            .map{
                $0.articles
        }
            .eraseToAnyPublisher()
            
        return dataPublisher
    }
}

