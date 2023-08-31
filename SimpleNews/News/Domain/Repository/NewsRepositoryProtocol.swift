//
//  NewsRepository.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation

public protocol NewsRepositoryProtocol {
  func getNews(page: Int, completion: @escaping ([News]?) -> Void)
  func getSearchNews(query: String, page: Int, completion: @escaping ([News]?) -> Void)
}
