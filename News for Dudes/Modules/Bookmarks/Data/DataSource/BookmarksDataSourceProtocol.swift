//
//  BookmarksDataSourceProtocol.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Foundation

protocol BookmarksDataSourceProtocol {
    func fetchBookmarks(completion: @escaping (Result<[Bookmarks], Error>) -> Void)
}
