//
//  News+CoreDataClass.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-13.
//
//

import Foundation
import CoreData

@objc(Bookmarks)
public class Bookmarks: NSManagedObject {}

extension Bookmarks {
    @NSManaged public var title: String?
    @NSManaged public var source: String?
    @NSManaged public var author: String?
    @NSManaged public var newsDescription: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var content: String?
}
extension Bookmarks {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmarks> {
        return NSFetchRequest<Bookmarks>(entityName: "Bookmarks")
    }
}
extension Bookmarks : Identifiable {}
