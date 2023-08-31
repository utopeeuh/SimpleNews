//
//  DeleteFavoriteNews.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 01/09/23.
//

import Foundation

public protocol DeleteFavoriteNewsUseCaseProtocol {
  func execute(news: News)
}

open class DeleteFavoriteNewsUseCase: DeleteFavoriteNewsUseCaseProtocol {
  private let repository = NewsRepository()
  
  public init() { }

  public func execute(news: News) {
    repository.deleteFavoriteNews(news: news)
  }
}

