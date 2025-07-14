//
//  NewsViewModel.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import Foundation

class NewsViewModel {
    let news: Dynamic<[NetworkNews]> = Dynamic(value: [])
    

    let fetchNetworkNewsUseCase:FetchNetworkNewsUseCaseProtocol
    init(fetchNetworkNewsUseCase: FetchNetworkNewsUseCaseProtocol) {
        self.fetchNetworkNewsUseCase = fetchNetworkNewsUseCase
    }
    
    func getNews(category: NewsCategory) {
           fetchNetworkNewsUseCase.executeFetch(category: category) { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let news):
                       self?.news.value = news
                   case .failure(let error):
                       print("Error: \(error)")
                   }
               }
           }
       }
}



    
    
  
