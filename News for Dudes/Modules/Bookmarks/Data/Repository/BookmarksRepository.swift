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
    
    func fetchBookmarks() -> AnyPublisher<[Bookmarks], any Error> {
         dataSource.fetchBookmarks()
    }

}
