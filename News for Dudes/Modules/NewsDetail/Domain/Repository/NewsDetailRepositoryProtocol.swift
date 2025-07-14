//
//  DeleteNewsRepositoryProtocol.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Foundation


protocol NewsDetailRepositoryProtocol{
    func getNews(completion: @escaping (Result<NewsDetailModel, Error>) -> Void)
    func deleteNews()
    func saveNews()
    func isNewsSaved()->Bool
}
