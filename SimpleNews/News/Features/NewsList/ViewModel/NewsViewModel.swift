//
//  NewsViewModel.swift
//  Simple News
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation

enum NewsType: Int, CaseIterable {
  case regular
  case favorites
  case offline
}

class NewsViewModel {
  
  var news : [News]? {
    NetworkMonitor.shared.isConnected ? onlineNews : getOfflineNews()
  }
  
  private var onlineNews: [News]? = nil
  private(set) var favoriteNews: [News] = []
  
  private var page = 0
  private var isStillFetchingNews = false
  private var isSearchOn = false
  
  var searchQuery = "" {
    didSet{
      page = 0
      isSearchOn = searchQuery != ""
      onlineNews?.removeAll()
      
      if searchQuery != "" {
        saveSearchHistoryUseCase.execute(query: searchQuery)
      }
    }
  }
  
  private let getNewsUseCase = GetNewsUseCase()
  private let getSearchNewsUseCase = GetSearchNewsUseCase()
  private let saveSearchHistoryUseCase = SaveSearchHistoryUseCase()
  private let getSearchHistoryUseCase = GetSearchHistoryUseCase()
  private let saveOfflineNewsUseCase = SaveOfflineNewsUseCase()
  private let getOfflineNewsUseCase = GetOfflineNewsUseCase()
  private let saveFavoriteNewsUseCase = SaveFavoriteNewsUseCase()
  private let getFavoriteNewsUseCase = GetFavoriteNewsUseCase()
  private let deleteFavoriteNewsUseCase = DeleteFavoriteNewsUseCase()
  
  init() { }
  
  func getSearchHistoryHeight() -> CGFloat {
    let cellHeight = 45
    return CGFloat(min(cellHeight*getSearchHistory().count, 300))
  }
  
  func isNewsFavorited(news: News?) -> Bool {
    if news == nil {
      return false
    }
    return favoriteNews.contains(where: {$0.id == news?.id})
  }
  
}

extension NewsViewModel {
  func getNews(completion: @escaping (Bool) -> Void){
    if isSearchOn {
      getSearchNews {completion($0)}
    } else {
      getRegularNews {completion($0)}
    }
  }
  
  private func getRegularNews(completion: @escaping (Bool) -> Void){
    if !isStillFetchingNews {
      getNewsUseCase.execute(page: page) { [weak self] news in
        DispatchQueue.main.async {
          guard let self = self else { return }
          if self.news == nil || self.news?.isEmpty ?? true {
            self.onlineNews = news
            self.saveOfflineNewsUseCase.execute(news: news ?? [])
          } else {
            self.onlineNews?.append(contentsOf: news ?? [])
          }
          self.isStillFetchingNews = false
          completion(news != nil)
        }
      }
      page += 1
    }
    isStillFetchingNews = true
  }
  
  private func getSearchNews(completion: @escaping (Bool) -> Void){
    if !isStillFetchingNews {
      getSearchNewsUseCase.execute(query: searchQuery, page: page) { [weak self] news in
        DispatchQueue.main.async {
          guard let self = self else { return }
          if self.news == nil || self.news?.isEmpty ?? true {
            self.onlineNews = news
          } else {
            self.onlineNews?.append(contentsOf: news ?? [])
          }
          self.isStillFetchingNews = false
          completion(news != nil)
        }
      }
      page += 1
    }
    isStillFetchingNews = true
  }
  
  func getSearchHistory() -> [String] {
    return getSearchHistoryUseCase.execute()
  }
  
  func getOfflineNews() -> [News] {
    return getOfflineNewsUseCase.execute()
  }
  
  func saveFavoriteNews(news: News?) {
    if let news = news {
      saveFavoriteNewsUseCase.execute(news: news)
    }
  }
  
  func getFavoriteNews() {
    favoriteNews = getFavoriteNewsUseCase.execute()
  }
  
  func deleteFavoriteNews(news: News) {
    deleteFavoriteNewsUseCase.execute(news: news)
  }
}
