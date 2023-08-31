//
//  UIViewController.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation
import UIKit

extension UIViewController {
  
  func showLoading() {
    let loading = LoadingView()
    loading.show()
  }

  func dismissLoading(willDismissQueue: Bool = false) {
    let loading = LoadingView()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      loading.dismiss(willDismissQueue: willDismissQueue)
    }
  }
  
  func addTapGestureToHideKeyboard() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }

  @IBAction func hideKeyboard() {
    view.endEditing(true)
  }
}
