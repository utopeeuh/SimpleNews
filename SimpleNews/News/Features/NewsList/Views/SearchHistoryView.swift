//
//  SearchHistoryView.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation
import UIKit

class SearchHistoryView: UIView {
  
  var searchHistoryQueryHandler: ((String) -> Void)?
  
  let dummySearchQueries = [
      "Best restaurants in town",
      "Weather forecast tomorrow",
      "How to bake a cake",
      "Top travel destinations",
      "Latest technology trends",
      "Healthy breakfast recipes",
      "Learn to play guitar",
      "Home workout routines",
      "DIY home decor ideas",
      "Beginner meditation techniques"
  ]
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.layer.cornerRadius = 8
    tableView.layer.borderWidth = 0.5
    tableView.layer.borderColor = UIColor.lightGray.cgColor
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchHistoryTable")
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SearchHistoryView: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dummySearchQueries.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "searchHistoryTable", for: indexPath)
    cell.textLabel?.text = dummySearchQueries[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    searchHistoryQueryHandler?(dummySearchQueries[indexPath.row])
  }
}
