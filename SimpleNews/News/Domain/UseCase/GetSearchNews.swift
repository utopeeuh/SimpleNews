//
//  GetSearchNews.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation

public protocol GetSearchNewsUseCaseProtocol {
  func execute(query: String, page: Int, completion: @escaping ([News]?) -> Void)
}

open class GetSearchNewsUseCase: GetSearchNewsUseCaseProtocol {
  private let repository = NewsRepository()
  
  public init() { }

  public func execute(query: String, page: Int = 0, completion: @escaping ([News]?) -> Void) {
    repository.getSearchNews(query: query, page: page, completion: {completion($0)})
  }
}
