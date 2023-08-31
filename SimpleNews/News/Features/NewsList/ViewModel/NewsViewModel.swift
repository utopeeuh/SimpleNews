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
  
  private(set) var news : [News]? = nil
  
  private var page = 0
  private var isStillFetchingNews = false
  private var isSearchOn = false
  var searchQuery = "" {
    didSet{
      page = 0
      isSearchOn = searchQuery != ""
      news?.removeAll()
    }
  }
  
  private let getNewsUseCase = GetNewsUseCase()
  private let getSearchNewsUseCase = GetSearchNewsUseCase()
  
  init() { }
  
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
            self.news = news
          } else {
            self.news?.append(contentsOf: news ?? [])
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
            self.news = news
          } else {
            self.news?.append(contentsOf: news ?? [])
          }
          self.isStillFetchingNews = false
          completion(news != nil)
        }
      }
      page += 1
    }
    isStillFetchingNews = true
  }
}
