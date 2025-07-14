//
//  NewsDetailDataSource.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import UIKit
import Combine
import CoreData


final class NewsDetailDataSource:NewsDetailDataSourceProtocol{
    
    private var appDelegate:AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context:NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    let model:NewsDetailModel?
    let mode:NewsDetailMode
    
    init(model: NewsDetailModel?,mode:NewsDetailMode) {
        self.model = model
        self.mode = mode
    }
    
    func getNews() -> AnyPublisher<NewsDetailModel, any Error> {
        guard let news = model else {
            return Fail(error: NSError(domain: "NewsDetailDataSource", code: -1, userInfo: [NSLocalizedDescriptionKey: "News = nil"]))
                .eraseToAnyPublisher()
        }
        
        return Just(news)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    
    func saveNews() {
        guard let bookmarksEntifyDescription = NSEntityDescription.entity(forEntityName: "Bookmarks", in: context) else {return}
        let bookmark = Bookmarks(entity: bookmarksEntifyDescription, insertInto: context)
        bookmark.author = self.model?.author
        bookmark.content = self.model?.content
        bookmark.newsDescription = self.model?.description
        bookmark.publishedAt = self.model?.publishedAt
        bookmark.source = self.model?.source
        bookmark.title = self.model?.title
        bookmark.urlToImage = self.model?.urlToImage
        appDelegate.saveContext()
        NotificationCenter.default.post(name: NSNotification.Name("didChange"), object: nil)
        
    }
    
    func isNewsSaved() -> Bool {
        let request = Bookmarks.fetchRequest()
        request.predicate = predicates()
        
        do{
            let result = try context.fetch(request)
            return !result.isEmpty
        }catch{
            print("ошибка в isNewsSaved")
            return false
        }
    }

    func deleteNews() {
        let request = Bookmarks.fetchRequest()
        request.predicate = predicates()
        do{
            let result = try context.fetch(request)
            for objects in result {
                context.delete(objects)
            }
            try context.save()
            NotificationCenter.default.post(name: NSNotification.Name("didChange"), object: nil)
        }catch{
            print("ошибка удаления")
        }
    }
    
}

private extension NewsDetailDataSource{
    func predicates() -> NSPredicate{
        var predicates = [NSPredicate]()
        
        if let title = model?.title {
            predicates.append(NSPredicate(format: "title == %@", title))
        }else {
            predicates.append(NSPredicate(format: "title == nil"))
        }
        
        if let description = model?.description {
            predicates.append(NSPredicate(format: "newsDescription == %@", description))
        }else {
            predicates.append(NSPredicate(format: "newsDescription == nil"))
        }
        
        if let publishedAt = model?.publishedAt {
            predicates.append(NSPredicate(format: "publishedAt == %@", publishedAt))
        } else {
            predicates.append(NSPredicate(format: "publishedAt == nil"))
        }
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
}
