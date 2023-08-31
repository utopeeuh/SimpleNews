//
//  SaveFavoriteNews.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 01/09/23.
//

import Foundation

public protocol SaveFavoriteNewsUseCaseProtocol {
  func execute(news: News)
}

open class SaveFavoriteNewsUseCase: SaveFavoriteNewsUseCaseProtocol {
  private let repository = NewsRepository()
  
  public init() { }

  public func execute(news: News) {
    repository.saveFavoriteNews(news: news)
  }
}
