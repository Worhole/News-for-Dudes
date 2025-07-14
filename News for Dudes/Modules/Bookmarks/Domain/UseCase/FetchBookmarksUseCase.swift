//
//  F
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Foundation

protocol FetchBookmarksUseCaseProtocol {
    func executeFetchBookmarks(completion: @escaping (Result<[Bookmarks], Error>) -> Void)
}

final class FetchBookmarksUseCase:FetchBookmarksUseCaseProtocol{
    
    private let repository:BookmarksRepositoryProtocol
    
    init(repository: BookmarksRepositoryProtocol) {
        self.repository = repository
    }
    
    func executeFetchBookmarks(completion: @escaping (Result<[Bookmarks], any Error>) -> Void) {
        repository.fetchBookmarks(completion: completion)
    }
    
}
