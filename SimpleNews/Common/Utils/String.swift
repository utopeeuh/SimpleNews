//
//  String.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation

extension String {
  func urlQueryFormat() -> String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
  }
  
  func convertDateStringFormat() -> String {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    guard let inputDate = inputDateFormatter.date(from: self) else { return self }

    // Create a DateFormatter instance for the desired output format
    let outputDateFormatter = DateFormatter()
    outputDateFormatter.dateFormat = "dd MMM yyyy, h:mma"
    outputDateFormatter.amSymbol = "AM"
    outputDateFormatter.pmSymbol = "PM"
    return outputDateFormatter.string(from: inputDate)
  }
}
