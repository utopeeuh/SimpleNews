//
//  NewsRepository.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation

public struct NewsRepository: NewsRepositoryProtocol {
  fileprivate let remoteDataSource = NewsRemoteDataSource()
  //  fileprivate let localDataSource = NewsLocalDataSource()
  
  public init() { }
  
  public func getNews(page: Int = 0, completion: @escaping ([News]?) -> Void) {
    remoteDataSource.getNews(page: page, completion: {completion($0)})
  }
  
  public func getSearchNews(query: String, page: Int = 0, completion: @escaping ([News]?) -> Void) {
    remoteDataSource.getSearchNews(query: query, page: page, completion: {completion($0)})
  }
  
}
