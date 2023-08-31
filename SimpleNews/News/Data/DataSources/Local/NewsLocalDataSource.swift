//
//  NewsLocalDataSource.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 01/09/23.
//

import Foundation

public protocol NewsLocalDataSourceProtocol {
  func saveSearchHistory(query: String)
  func getSearchHistory() -> [String]
  
  func saveOfflineNews(news: [News])
  func getOfflineNews() -> [News]
  
  func saveFavoriteNews(news: News)
  func getFavoriteNews() -> [News]
  func deleteFavoriteNews(news: News)
}

public struct NewsLocalDataSource: NewsLocalDataSourceProtocol {
  
  public init() {}
  
  public func saveSearchHistory(query: String) {
    if getSearchHistory().count == 10 {
      CoreDataHelper.shared.deleteFirstEntity(SearchHistory.entityName)
    }
    
    let newSearchHistoryEntry = CoreDataHelper.shared.createEntity(SearchHistory.entityName) as SearchHistory
    newSearchHistoryEntry.query = query
    CoreDataHelper.shared.saveContext()
  }
  
  public func getSearchHistory() -> [String] {
    return (CoreDataHelper.shared.fetchEntities(SearchHistory.entityName) as [SearchHistory]).map {$0.query ?? ""}.reversed()
  }
  
  public func saveOfflineNews(news: [News]) {
    if getOfflineNews().count == 10 {
      return
    }
    
    let finalOfflineNews = news.prefix(10)
    finalOfflineNews.forEach { news in
      let newOfflineNews = CoreDataHelper.shared.createEntity(OfflineNews.entityName) as OfflineNews
      newOfflineNews.configure(news: news)
    }
    CoreDataHelper.shared.saveContext()
  }
  
  public func getOfflineNews() -> [News] {
    let offlineNewsEntities = CoreDataHelper.shared.fetchEntities(OfflineNews.entityName) as [OfflineNews]
    let newsArray = offlineNewsEntities.map { offlineNews in
      var news = News()
      news.configure(newsObject: offlineNews)
      return news
    }
    return newsArray
  }
  
  public func saveFavoriteNews(news: News) {
    let newFavoriteNews = CoreDataHelper.shared.createEntity(FavoriteNews.entityName) as FavoriteNews
    newFavoriteNews.configure(news: news)
    CoreDataHelper.shared.saveContext()
  }
  
  public func getFavoriteNews() -> [News] {
    let FavoriteNewsEntities = CoreDataHelper.shared.fetchEntities(FavoriteNews.entityName) as [FavoriteNews]
    let newsArray = FavoriteNewsEntities.map { favoriteNews in
      var news = News()
      news.configure(newsObject: favoriteNews)
      return news
    }
    return newsArray
  }
  
  public func deleteFavoriteNews(news: News) {
    let predicate = NSPredicate(format: "id == %@", news.id ?? "")
    CoreDataHelper.shared.deleteEntity(FavoriteNews.entityName, predicate: predicate)
  }
}
