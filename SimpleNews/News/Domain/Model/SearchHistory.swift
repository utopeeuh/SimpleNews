//
//  SearchHistory.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 01/09/23.
//

import Foundation
import CoreData

@objc(SearchHistory)
public class SearchHistory: NSManagedObject {
  static let entityName = "SearchHistory"
  @NSManaged public var query: String?
}
