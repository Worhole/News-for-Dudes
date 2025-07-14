//
//  BookmarksRepositoryProtocol.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Combine

protocol BookmarksRepositoryProtocol {
    func fetchBookmarks() -> AnyPublisher<[Bookmarks],any Error>
}
