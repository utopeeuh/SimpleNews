//
//  OfflineNews.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 01/09/23.
//

import Foundation
import CoreData

@objc(OfflineNews)
public class OfflineNews: NSManagedObject {
  static let entityName = "OfflineNews"
  @NSManaged public var id: String?
  @NSManaged public var date: String?
  @NSManaged public var imageUrl: String?
  @NSManaged public var paragraph: String?
  @NSManaged public var snippet: String?
  @NSManaged public var title: String?
  
  public func configure(news: News){
    id = news.id
    date = news.pubDate?.convertDateStringFormat()
    imageUrl = news.multimedia?.first?.url
    paragraph = news.leadParagraph
    snippet = news.snippet
    title = news.headline?.main
  }
}





