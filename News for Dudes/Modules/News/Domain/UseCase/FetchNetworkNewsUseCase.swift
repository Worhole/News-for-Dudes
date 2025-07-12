//
//  FetchNewsUseCase.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import Combine


protocol FetchNetworkNewsUseCaseProtocol{
    func executeFetch(category:NewsCategory)-> AnyPublisher<[NetworkNews],any Error>
}

final class FetchNetworkNewsUseCase: FetchNetworkNewsUseCaseProtocol {
    
    private let repository:FetchNetworkNewsRepository
    
    init(repository: FetchNetworkNewsRepository) {
        self.repository = repository
    }
    
    func executeFetch(category:NewsCategory) -> AnyPublisher<[NetworkNews], any Error> {
        repository.fetchNetworkNews(category: category)
    }
    
}
