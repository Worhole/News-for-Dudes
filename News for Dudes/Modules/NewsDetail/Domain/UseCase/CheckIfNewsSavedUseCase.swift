//
//  CheckIfNewsSavedUseCase.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Foundation

protocol CheckIfNewsSavedUseCaseProtocol{
    func executeIsNewsSaved() -> Bool
}

final class CheckIfNewsSavedUseCase:CheckIfNewsSavedUseCaseProtocol{
    
    let repository:NewsDetailRepositoryProtocol
    
    init(repository: NewsDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func executeIsNewsSaved() -> Bool {
        repository.isNewsSaved()
    }
}
