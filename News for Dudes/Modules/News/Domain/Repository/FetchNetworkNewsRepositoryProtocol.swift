//
//  Repository.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import Combine


protocol FetchNetworkNewsRepositoryProtocol {
    func fetchNetworkNews(category: NewsCategory, completion: @escaping (Result<[NetworkNews], Error>) -> Void)
}
