//
//  NewsModuleBuilder.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import Foundation

class NewsModuleBuilder {
    static func build()->NewsViewController{
        
        let dataSource = NewsDataSource()
        let repository = FetchNetworkNewsRepository(dataSource: dataSource)
        let useCase = FetchNetworkNewsUseCase(repository: repository)
        let viewModel = NewsViewModel(fetchNetworkNewsUseCase: useCase)
        let view = NewsViewController()
        view.viewModel = viewModel
        
        return view
    }
}
