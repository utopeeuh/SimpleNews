//
//  GetSearchHistory.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 01/09/23.
//

import Foundation

public protocol GetSearchHistoryUseCaseProtocol {
  func execute() -> [String]
}

open class GetSearchHistoryUseCase: GetSearchHistoryUseCaseProtocol {
  private let repository = NewsRepository()
  
  public init() { }

  public func execute() -> [String] {
    return repository.getSearchHistory()
  }
}
