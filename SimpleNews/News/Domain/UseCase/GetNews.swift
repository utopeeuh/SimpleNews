//
//  GetNews.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation

public protocol GetNewsUseCaseProtocol {
  func execute(page: Int, completion: @escaping ([News]?) -> Void)
}

open class GetNewsUseCase: GetNewsUseCaseProtocol {
  private let repository = NewsRepository()
  
  public init() { }

  public func execute(page: Int = 0, completion: @escaping ([News]?) -> Void) {
    repository.getNews(page: page, completion: {completion($0)})
  }
}
