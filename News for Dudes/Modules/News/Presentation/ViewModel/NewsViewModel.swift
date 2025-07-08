//
//  NewsViewModel.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import Foundation
import Combine

class NewsViewModel {
    
    @Published var news: [NetworkNews] = []
    private var cancelables = Set<AnyCancellable>()
    
    let fetchNetworkNewsUseCase:FetchNetworkNewsUseCaseProtocol
    init(fetchNetworkNewsUseCase: FetchNetworkNewsUseCaseProtocol) {
        self.fetchNetworkNewsUseCase = fetchNetworkNewsUseCase
    }
    
    func getNews() {
        fetchNetworkNewsUseCase.executeFetch()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                default: break
                }
            } receiveValue: { [weak self] news in
                self?.news = news
            }
            .store(in: &cancelables)
    }
}



    
    
  
