//
//  FetchNewsUseCase.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import Foundation


protocol FetchNetworkNewsUseCaseProtocol{
    func executeFetch(category: NewsCategory, completion: @escaping (Result<[NetworkNews], Error>) -> Void)
}

final class FetchNetworkNewsUseCase: FetchNetworkNewsUseCaseProtocol {
    
    private let repository:FetchNetworkNewsRepositoryProtocol
    
    init(repository: FetchNetworkNewsRepositoryProtocol) {
        self.repository = repository
    }
    
    func executeFetch(category: NewsCategory, completion: @escaping (Result<[NetworkNews], any Error>) -> Void) {
        repository.fetchNetworkNews(category: category, completion: completion)
    }
    
}
