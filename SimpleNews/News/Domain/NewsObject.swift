//
//  NewsObject.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 01/09/23.
//

import Foundation

public protocol NewsObject {
  var id: String? { get set }
  var date: String? { get set }
  var imageUrl: String? { get set }
  var paragraph: String? { get set }
  var snippet: String? { get set }
  var title: String? { get set }
}

extension OfflineNews: NewsObject { }
extension FavoriteNews: NewsObject { }
