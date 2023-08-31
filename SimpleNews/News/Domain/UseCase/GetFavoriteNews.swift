//
//  GetFavoriteNews.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 01/09/23.
//

import Foundation

public protocol GetFavoriteNewsUseCaseProtocol {
  func execute() -> [News]
}

open class GetFavoriteNewsUseCase: GetFavoriteNewsUseCaseProtocol {
  private let repository = NewsRepository()
  
  public init() { }

  public func execute() -> [News] {
    return repository.getFavoriteNews()
  }
}

