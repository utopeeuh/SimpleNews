//
//  SaveSearchHistory.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 01/09/23.
//

import Foundation

public protocol SaveSearchHistoryUseCaseProtocol {
  func execute(query: String)
}

open class SaveSearchHistoryUseCase: SaveSearchHistoryUseCaseProtocol {
  private let repository = NewsRepository()
  
  public init() { }

  public func execute(query: String) {
    repository.saveSearchHistory(query: query)
  }
}
