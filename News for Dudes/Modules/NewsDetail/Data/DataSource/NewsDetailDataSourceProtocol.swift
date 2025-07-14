//
//  SaveNewsDataSourceProtocol.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Foundation
import Combine

protocol NewsDetailDataSourceProtocol{
    func deleteNews()
    func getNews() -> AnyPublisher<NewsDetailModel,Error>
    func saveNews()
    func isNewsSaved()->Bool
}
