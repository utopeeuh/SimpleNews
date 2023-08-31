//
//  News.swift
//  Simple News
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//
import Foundation

public struct Root {
  var copyright: String?
  var status: String?
  var response: Response?
}

public struct Response {
  var news: [News]?
}

public struct News {
  var uri: String?
  var byline: Byline?
  var pubDate: String?
  var abstract: String?
  var webUrl: String?
  var multimedia: [Multimedia]?
  var wordCount: Int?
  var typeOfMaterial: String?
  var snippet: String?
  var documentType: String?
  var source: String?
  var headline: Headline?
  var leadParagraph: String?
  var sectionName: String?
  var subsectionName: String?
  var newsDesk: String?
  var id: String?
  
  public mutating func configure(newsObject: NewsObject) {
    id = newsObject.id
    pubDate = newsObject.date
    multimedia = [Multimedia(url: newsObject.imageUrl)]
    leadParagraph = newsObject.paragraph
    snippet = newsObject.snippet
    headline = Headline(main: newsObject.title)
  }
}



public struct Byline {
  var person: [Int]?
  var organization: String?
  var original: String?
}

public struct Multimedia {
  var url: String?
  var caption: Any?
  var width: Int?
  var type: String?
  var subType: String?
  var credit: Any?
  var subtype: String?
  var height: Int?
  var rank: Int?
  var cropName: String?
}

public struct Headline {
  var main: String?
}
