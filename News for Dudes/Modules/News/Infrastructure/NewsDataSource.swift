//
//  FetchNetworkNewsDataSource.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import Combine
import Foundation

final class NewsDataSource:NewsDataSourceProtocol {
    func fetchNetworkNews(category: NewsCategory, completion: @escaping (Result<[NetworkNews], any Error>) -> Void) {
        guard let url = NewsURLBuilder(newsCategory: category).url else {
            completion(.failure(URLError.badURL as! Error))
            return
        }
        URLSession.shared.dataTask(with: url){ data,_,error in
            if let error = error {
                print(error)
            }
            guard let data = data, let decodeData = try? JSONDecoder().decode(Articles.self, from: data) else { completion(.failure(URLError.dataNotAllowed as! Error))
                return}
            
            completion(.success(decodeData.articles))
        }.resume()
    }

}

