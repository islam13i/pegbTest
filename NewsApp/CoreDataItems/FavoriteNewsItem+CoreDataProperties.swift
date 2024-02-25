//
//  FavoriteNewsItem+CoreDataProperties.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//
//

import Foundation
import CoreData


extension FavoriteNewsItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteNewsItem> {
        return NSFetchRequest<FavoriteNewsItem>(entityName: "FavoriteNewsItem")
    }

    @NSManaged public var newsAuthor: String?
    @NSManaged public var newsImage: String?
    @NSManaged public var newsTitle: String?
    @NSManaged public var newsDescription: String?
    @NSManaged public var newsPublishDate: String?
    @NSManaged public var newsContent: String?
    @NSManaged public var newsUrlLink: String?

}

extension FavoriteNewsItem : Identifiable {

}
