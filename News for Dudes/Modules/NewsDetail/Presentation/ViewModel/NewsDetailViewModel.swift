//
//  NewsDetailViewModel.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-12.
//

import Foundation
import Combine

class NewsDetailViewModel {
    
    @Published var viewData:NewsDetailViewData?
    @Published var isSaved:Bool = false
    let mode:NewsDetailMode
    let close:(()->Void)?
    
    private var cancelables = Set<AnyCancellable>()
    
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
    
    func getNews(){
        getNewsUseCase.executeGetNews()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                default: break
                }
            } receiveValue: { [weak self] news in
                self?.viewData = NewsDetailViewData(model: news)
            }
            .store(in: &cancelables)
    }
    
    func buttonTapped(){
        if isSaved {
            deleteNewsUseCase.executeDeleteNews()
            saveComplete()
        } else {
            saveNewsUseCase.executeSaveNews()
            saveComplete()
        }
    }
    
}

private extension NewsDetailViewModel{
    func checkIfSavedNews(){
        switch mode {
        case .networkNews:
            isSaved = checkIfSavedUseCase.executeIsNewsSaved()
        case .bookmarks:
            isSaved = true
        }
       
    }
    
    func saveComplete(){
        checkIfSavedNews()
        if mode == .bookmarks {
            close?()
        }
    }
}
