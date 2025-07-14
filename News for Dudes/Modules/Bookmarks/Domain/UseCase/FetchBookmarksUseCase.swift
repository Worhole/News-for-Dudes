//
//  F
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Combine

protocol FetchBookmarksUseCaseProtocol {
    func executeFetch()-> AnyPublisher<[Bookmarks],any Error>
}

final class FetchBookmarksUseCase:FetchBookmarksUseCaseProtocol{
    
    private let repository:BookmarksRepositoryProtocol
    
    init(repository: BookmarksRepositoryProtocol) {
        self.repository = repository
    }
    
    func executeFetch() -> AnyPublisher<[Bookmarks], any Error> {
        repository.fetchBookmarks()
    }
    
}
