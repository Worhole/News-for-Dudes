//
//  DeleteNewsRepositoryProtocol.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Combine


protocol NewsDetailRepositoryProtocol{
    func getNews() -> AnyPublisher<NewsDetailModel,Error>
    func deleteNews()
    func saveNews()
    func isNewsSaved()->Bool
}
