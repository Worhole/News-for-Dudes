//
//  NewsDetailViewModel.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-12.
//

import Foundation


class NewsDetailViewModel {
    
    var viewData: ((NewsDetailViewData) -> Void)?
    var isSaved: ((Bool) -> Void)?
    
    private(set) var currentIsSaved: Bool = false {
        didSet {
            isSaved?(currentIsSaved)
        }
    }
    let mode:NewsDetailMode
    let close:(()->Void)?
    
    
    let getNewsUseCase:GetNewsUseCaseProtocol
    let saveNewsUseCase:SaveNewsUseCaseProtocol
    let deleteNewsUseCase:DeleteNewsUseCaseProtocol
    let checkIfSavedUseCase:CheckIfNewsSavedUseCaseProtocol
    
    init(getNewsUseCase: GetNewsUseCaseProtocol, saveNewsUseCase: SaveNewsUseCaseProtocol, deleteNewsUseCase: DeleteNewsUseCaseProtocol,checkIfSavedUseCase: CheckIfNewsSavedUseCaseProtocol,mode:NewsDetailMode, close: @escaping () -> Void = {}) {
        self.getNewsUseCase = getNewsUseCase
        self.saveNewsUseCase = saveNewsUseCase
        self.deleteNewsUseCase = deleteNewsUseCase
        self.checkIfSavedUseCase = checkIfSavedUseCase
        self.mode = mode
        self.close = close
        
        checkIfSavedNews()
    }
    func getNews() {
        getNewsUseCase.executeGetNews { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    self?.viewData?(NewsDetailViewData(model: news))
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    
    func buttonTapped() {
         if currentIsSaved {
             deleteNewsUseCase.executeDeleteNews()
             saveComplete()
         } else {
             saveNewsUseCase.executeSaveNews()
             saveComplete()
         }
     }
    
}

private extension NewsDetailViewModel {
    
    func checkIfSavedNews() {
        switch mode {
        case .networkNews:
            currentIsSaved = checkIfSavedUseCase.executeIsNewsSaved()
        case .bookmarks:
            currentIsSaved = true
        }
    }
    
    func saveComplete() {
        checkIfSavedNews()
        if mode == .bookmarks {
            close?()
        }
    }
}
