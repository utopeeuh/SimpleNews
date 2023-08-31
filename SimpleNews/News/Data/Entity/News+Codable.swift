//
//  News.swift
//  Simple News
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//
import Foundation

extension Root: Codable {
  enum CodingKeys: String, CodingKey {
    
    case copyright = "copyright"
    case status = "status"
    case response = "response"
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    copyright = try? container.decode(String.self, forKey: .copyright)
    status = try? container.decode(String.self, forKey: .status)
    response = try? container.decode(Response.self, forKey: .response)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try? container.encode(copyright, forKey: .copyright)
    try? container.encode(status, forKey: .status)
    try? container.encode(response, forKey: .response)
  }
}

extension Response: Codable {
  
  enum CodingKeys: String, CodingKey {
    case news = "docs"
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    news = try? container.decode([News].self, forKey: .news)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try? container.encode(news, forKey: .news)
  }
}

extension News: Codable {
  
  enum CodingKeys: String, CodingKey {
    case uri = "uri"
    case byline = "byline"
    case pubDate = "pub_date"
    case abstract = "abstract"
    case webUrl = "web_url"
    case multimedia = "multimedia"
    case wordCount = "word_count"
    case typeOfMaterial = "type_of_material"
    case snippet = "snippet"
    case documentType = "document_type"
    case source = "source"
    case keywords = "keywords"
    case headline = "headline"
    case leadParagraph = "lead_paragraph"
    case sectionName = "section_name"
    case subsectionName = "subsection_name"
    case newsDesk = "news_desk"
    case id = "_id"
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    uri = try? container.decode(String.self, forKey: .uri)
    byline = try? container.decode(Byline.self, forKey: .byline)
    pubDate = try? container.decode(String.self, forKey: .pubDate)
    abstract = try? container.decode(String.self, forKey: .abstract)
    webUrl = try? container.decode(String.self, forKey: .webUrl)
    multimedia = try? container.decode([Multimedia].self, forKey: .multimedia)
    wordCount = try? container.decode(Int.self, forKey: .wordCount)
    typeOfMaterial = try? container.decode(String.self, forKey: .typeOfMaterial)
    snippet = try? container.decode(String.self, forKey: .snippet)
    documentType = try? container.decode(String.self, forKey: .documentType)
    source = try? container.decode(String.self, forKey: .source)
    headline = try? container.decode(Headline.self, forKey: .headline)
    leadParagraph = try? container.decode(String.self, forKey: .leadParagraph)
    sectionName = try? container.decode(String.self, forKey: .sectionName)
    subsectionName = try? container.decode(String.self, forKey: .subsectionName)
    newsDesk = try? container.decode(String.self, forKey: .newsDesk)
    id = try? container.decode(String.self, forKey: .id)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try? container.encode(uri, forKey: .uri)
    try? container.encode(byline, forKey: .byline)
    try? container.encode(pubDate, forKey: .pubDate)
    try? container.encode(abstract, forKey: .abstract)
    try? container.encode(webUrl, forKey: .webUrl)
    try? container.encode(multimedia, forKey: .multimedia)
    try? container.encode(wordCount, forKey: .wordCount)
    try? container.encode(typeOfMaterial, forKey: .typeOfMaterial)
    try? container.encode(snippet, forKey: .snippet)
    try? container.encode(documentType, forKey: .documentType)
    try? container.encode(source, forKey: .source)
    try? container.encode(headline, forKey: .headline)
    try? container.encode(leadParagraph, forKey: .leadParagraph)
    try? container.encode(sectionName, forKey: .sectionName)
    try? container.encode(subsectionName, forKey: .subsectionName)
    try? container.encode(newsDesk, forKey: .newsDesk)
    try? container.encode(id, forKey: .id)
  }
}

extension Byline: Codable {
  
  enum CodingKeys: String, CodingKey {
    case person = "person"
    case organization = "organization"
    case original = "original"
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    person = try? container.decode([Int].self, forKey: .person)
    organization = try? container.decode(String.self, forKey: .organization)
    original = try? container.decode(String.self, forKey: .original)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try? container.encode(person, forKey: .person)
    try? container.encode(organization, forKey: .organization)
    try? container.encode(original, forKey: .original)
  }
}

extension Multimedia: Codable {

  enum CodingKeys: String, CodingKey {
    case url = "url"
    case caption = "caption"
    case width = "width"
    case type = "type"
    case subType = "subType"
    case credit = "credit"
    case subtype = "subtype"
    case height = "height"
    case rank = "rank"
    case cropName = "crop_name"
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    url = try? "https://www.nytimes.com/\(container.decode(String.self, forKey: .url))"
    width = try? container.decode(Int.self, forKey: .width)
    type = try? container.decode(String.self, forKey: .type)
    subType = try? container.decode(String.self, forKey: .subType)
    subtype = try? container.decode(String.self, forKey: .subtype)
    height = try? container.decode(Int.self, forKey: .height)
    rank = try? container.decode(Int.self, forKey: .rank)
    cropName = try? container.decode(String.self, forKey: .cropName)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try? container.encode(url, forKey: .url)
    try? container.encode(width, forKey: .width)
    try? container.encode(type, forKey: .type)
    try? container.encode(subType, forKey: .subType)
    try? container.encode(subtype, forKey: .subtype)
    try? container.encode(height, forKey: .height)
    try? container.encode(rank, forKey: .rank)
    try? container.encode(cropName, forKey: .cropName)
  }
}

extension Headline: Codable {

  enum CodingKeys: String, CodingKey {
    case main = "main"
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    main = try? container.decode(String.self, forKey: .main)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try? container.encode(main, forKey: .main)
  }
}
