//
//  NewsRemoteDataSource.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation

public protocol NewsRemoteDataSourceProtocol {
  func getNews(page: Int, completion: @escaping ([News]?) -> Void)
  func getSearchNews(query: String, page: Int, completion: @escaping ([News]?) -> Void)
}

public struct NewsRemoteDataSource: NewsRemoteDataSourceProtocol {
  
  public init() {}
  
  public func getNews(page: Int = 0, completion: @escaping ([News]?) -> Void) {
    let api = NewsApi.getNews(page: page)
    NetworkService.shared.connect(api: api, codableType: Root.self) { root in
      completion(root?.response?.news)
    }
  }
  
  public func getSearchNews(query: String, page: Int = 0, completion: @escaping ([News]?) -> Void) {
    let api = NewsApi.getSearchNews(query: query, page: page)
    NetworkService.shared.connect(api: api, codableType: Root.self) { root in
      completion(root?.response?.news)
    }
  }
}

