//
//  TabBarController.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let tabOne = NewsListViewController()
    let tabOneBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    
    tabOne.tabBarItem = tabOneBarItem
    
    let tabTwo = FavoriteNewsViewController()
    let tabTwoBarItem2 = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
    
    tabTwo.tabBarItem = tabTwoBarItem2
    
    self.viewControllers = [tabOne, tabTwo]
  }
}
