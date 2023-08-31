//
//  ImagesUI.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation
import UIKit

enum ImagesUI: String {
  case placeholder = "img-placeholder"
}

extension ImagesUI {
  func getImage() -> UIImage? {
    return UIImage(named: self.rawValue) ?? UIImage()
  }
}
