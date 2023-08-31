//
//  NewsRepository.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation

public struct NewsRepository: NewsRepositoryProtocol {
  
  fileprivate let remoteDataSource = NewsRemoteDataSource()
  fileprivate let localDataSource = NewsLocalDataSource()
  
  public init() { }
  
  public func getNews(page: Int = 0, completion: @escaping ([News]?) -> Void) {
    remoteDataSource.getNews(page: page, completion: {completion($0)})
  }
  
  public func getSearchNews(query: String, page: Int = 0, completion: @escaping ([News]?) -> Void) {
    remoteDataSource.getSearchNews(query: query, page: page, completion: {completion($0)})
  }
  
  public func saveSearchHistory(query: String) {
    localDataSource.saveSearchHistory(query: query)
  }
  
  public func getSearchHistory() -> [String] {
    return localDataSource.getSearchHistory()
  }
  
  public func saveOfflineNews(news: [News]) {
    localDataSource.saveOfflineNews(news: news)
  }
  
  public func getOfflineNews() -> [News] {
    return localDataSource.getOfflineNews()
  }
  
  public func saveFavoriteNews(news: News) {
    localDataSource.saveFavoriteNews(news: news)
  }
  
  public func getFavoriteNews() -> [News] {
    return localDataSource.getFavoriteNews()
  }
  
  public func deleteFavoriteNews(news: News) {
    localDataSource.deleteFavoriteNews(news: news)
  }
  
}
