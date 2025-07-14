//
//  DeleteNewsUseCase.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Foundation
import Combine

protocol DeleteNewsUseCaseProtocol {
    func executeDeleteNews()
}

final class DeleteNewsUseCase:DeleteNewsUseCaseProtocol{
    
    private let repository:NewsDetailRepositoryProtocol
    
    init(repository: NewsDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func executeDeleteNews() {
        repository.deleteNews()
    }
}
