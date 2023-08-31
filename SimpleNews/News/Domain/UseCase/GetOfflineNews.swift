//
//  GetOfflineNews.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 01/09/23.
//

import Foundation

public protocol GetOfflineNewsUseCaseProtocol {
  func execute() -> [News]
}

open class GetOfflineNewsUseCase: GetOfflineNewsUseCaseProtocol {
  private let repository = NewsRepository()
  
  public init() { }

  public func execute() -> [News] {
    return repository.getOfflineNews()
  }
}
