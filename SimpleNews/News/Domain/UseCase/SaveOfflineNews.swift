//
//  SaveOfflineNews.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 01/09/23.
//

import Foundation

public protocol SaveOfflineNewsUseCaseProtocol {
  func execute(news: [News])
}

open class SaveOfflineNewsUseCase: SaveOfflineNewsUseCaseProtocol {
  private let repository = NewsRepository()
  
  public init() { }

  public func execute(news: [News]) {
    repository.saveOfflineNews(news: news)
  }
}
