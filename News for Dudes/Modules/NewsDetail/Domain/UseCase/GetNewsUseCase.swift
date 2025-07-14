//
//  GetNewsUseCase.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-13.
//

import Foundation


protocol GetNewsUseCaseProtocol{
    func executeGetNews(completion: @escaping (Result<NewsDetailModel, Error>) -> Void)
}

final class GetNewsUseCase:GetNewsUseCaseProtocol {
    
    private let repository:NewsDetailRepositoryProtocol
    
    init(repository: NewsDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func executeGetNews(completion: @escaping (Result<NewsDetailModel, any Error>) -> Void) {
        repository.getNews(completion: completion)
    }
   
}
