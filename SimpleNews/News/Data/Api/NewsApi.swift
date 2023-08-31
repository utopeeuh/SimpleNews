//
//  NewsApi.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//


import Foundation

enum NewsApi {
  case getNews(page: Int)
  case getSearchNews(query: String, page: Int)
}

extension NewsApi: Api {
  var path: String {
    switch self {
    case .getNews(let page):
      return "search/v2/articlesearch.json?q=&page\(page)"
    case .getSearchNews(let query, let page):
      return "search/v2/articlesearch.json?q=\(query.urlQueryFormat())&page=\(page)"
    }
  }
}

