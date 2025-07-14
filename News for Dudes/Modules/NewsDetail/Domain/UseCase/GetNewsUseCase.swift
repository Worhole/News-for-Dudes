//
//  GetNewsUseCase.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-13.
//

import Foundation
import Combine

protocol GetNewsUseCaseProtocol{
    func executeGetNews() -> AnyPublisher<NewsDetailModel,Error>
}

final class GetNewsUseCase:GetNewsUseCaseProtocol {
    
    private let repository:NewsDetailRepositoryProtocol
    
    init(repository: NewsDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    
    func executeGetNews() -> AnyPublisher<NewsDetailModel, any Error> {
        repository.getNews()
    }
}
