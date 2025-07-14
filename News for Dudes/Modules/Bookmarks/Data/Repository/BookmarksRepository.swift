//
//  BookmarksRepository.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Combine

final class BookmarksRepository: BookmarksRepositoryProtocol {
    
    private let dataSource:BookmarksDataSourceProtocol
    
    init(dataSource: BookmarksDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func fetchBookmarks(completion: @escaping (Result<[Bookmarks], Error>) -> Void){
        dataSource.fetchBookmarks(completion: completion)
    }

}
