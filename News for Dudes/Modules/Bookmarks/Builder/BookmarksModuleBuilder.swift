//
//  BookmarksModuleBuilder.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Foundation


final class BookmarksModuleBuilder {
    static func build() -> BookmarksViewController{
        
        let dataSource = BookmarksDataSource()
        let repository = BookmarksRepository(dataSource: dataSource)
        let useCase = FetchBookmarksUseCase(repository: repository)
        let viewModel = BookmarksViewModel(fetchBookmarksUseCase: useCase)
        let view = BookmarksViewController()
        view.viewModel = viewModel
        
        return view
    }
}
