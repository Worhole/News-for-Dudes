//
//  NewsDetailsModuleBuilder.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-13.
//

import Foundation

enum NewsDetailMode{
    case networkNews
    case bookmarks
}

final class NewsDetailModuleBuilder {
    static func build(data:NewsDetailModel,mode:NewsDetailMode,close: @escaping () -> Void)->NewsDetailViewController{
        
        let view = NewsDetailViewController()
        
        let dataSource = NewsDetailDataSource(model: data,mode: mode)
        let repository = NewsDetailRepository(dataSource: dataSource)
        
        let getNewsUseCase = GetNewsUseCase(repository: repository)
        let saveNewsUseCase = SaveNewsUseCase(repository: repository)
        let deleteNewsUseCase = DeleteNewsUseCase(repository: repository)
        let checkIfSavedNewsUseCase = CheckIfNewsSavedUseCase(repository: repository)
        
        let viewModel = NewsDetailViewModel(getNewsUseCase: getNewsUseCase, saveNewsUseCase: saveNewsUseCase, deleteNewsUseCase: deleteNewsUseCase, checkIfSavedUseCase: checkIfSavedNewsUseCase, mode: mode, close: close)
        view.viewModel = viewModel
       
        return view
    }
}
