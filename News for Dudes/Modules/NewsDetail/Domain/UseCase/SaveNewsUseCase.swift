//
//  SaveNewsUseCase.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Foundation

protocol SaveNewsUseCaseProtocol {
    func executeSaveNews()
}

final class SaveNewsUseCase:SaveNewsUseCaseProtocol{
    
    private let repository:NewsDetailRepositoryProtocol
    
    init(repository: NewsDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func executeSaveNews() {
        repository.saveNews()
    }
}
