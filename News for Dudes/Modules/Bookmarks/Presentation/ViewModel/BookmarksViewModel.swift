//
//  BookmarksViewModel.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-13.
//

import Foundation
import Combine

class BookmarksViewModel {
    @Published var bookmarks = [Bookmarks]()
    
    private var cancelables = Set<AnyCancellable>()
    
    let fetchBookmarksUseCase:FetchBookmarksUseCaseProtocol
    init(fetchBookmarksUseCase: FetchBookmarksUseCaseProtocol) {
        self.fetchBookmarksUseCase = fetchBookmarksUseCase
        NotificationCenter.default.publisher(for: Notification.Name("didChange"))
            .sink { [weak self] _ in
            self?.fetchBookmarks()
            }.store(in: &cancelables)
    }
    
    func fetchBookmarks(){
        fetchBookmarksUseCase.executeFetch()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                default: break
                }
            } receiveValue: { [weak self] bookmarks in
                self?.bookmarks = bookmarks
            }
            .store(in: &cancelables)
    }
   
}
