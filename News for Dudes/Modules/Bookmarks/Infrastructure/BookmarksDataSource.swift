//
//  BookmarksDataSource.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Combine
import CoreData
import UIKit

final class BookmarksDataSource:BookmarksDataSourceProtocol{
    
    private var appDelegate:AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context:NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func fetchBookmarks(completion: @escaping (Result<[Bookmarks], Error>) -> Void) {
        context.perform {
            do {
                let fetchRequest = Bookmarks.fetchRequest()
                let results = try self.context.fetch(fetchRequest)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
    }

}
