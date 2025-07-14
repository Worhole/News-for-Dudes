//
//  BookmarksViewModel.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-13.
//

import Foundation

class BookmarksViewModel {
    var bookmarks: Dynamic<[Bookmarks]> = Dynamic(value: [])
      
      let fetchBookmarksUseCase: FetchBookmarksUseCaseProtocol
      
      init(fetchBookmarksUseCase: FetchBookmarksUseCaseProtocol) {
          self.fetchBookmarksUseCase = fetchBookmarksUseCase
          
          NotificationCenter.default.addObserver(
              self,
              selector: #selector(bookmarksDidChange),
              name: Notification.Name("didChange"),
              object: nil
          )
          
          fetchBookmarks()
      }
      
      deinit {
          NotificationCenter.default.removeObserver(self)
      }
      
      @objc private func bookmarksDidChange() {
          fetchBookmarks()
      }
      
      func fetchBookmarks() {
          fetchBookmarksUseCase.executeFetchBookmarks(completion: { [weak self] result in
              DispatchQueue.main.async {
                  switch result {
                  case .success(let bookmarks):
                      self?.bookmarks.value = bookmarks
                  case .failure(let error):
                      print(error)
                  }
              }
          })
      }
   
}
