//
//  FetchNetworkNewsDataSource.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import Combine
import Foundation

class FetchNetworkNewsDataSource:FetchNetworkNewsDataSourceProtocol {
    func getNetworkNews() -> AnyPublisher<[NetworkNews], any Error> {
        let apiKey = "3d09b62d49ba400586ed2a3b0a43380a"
        let urlStr = "https://newsapi.org/v2/everything?q=apple&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlStr) else { return Fail(error: URLError.badURL as! Error).eraseToAnyPublisher()}
        
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

