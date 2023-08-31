//
//  ViewController.swift
//  Simple News
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import UIKit
import SnapKit

class NewsListViewController: UIViewController {
  
  // MARK: - Properties
  private let viewModel = NewsViewModel()
  
  private var isCurrentlyScrolling = false
  
  // MARK: - UI Properties
  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.backgroundImage = UIImage()
    searchBar.placeholder = "Search here"
    searchBar.delegate = self
    return searchBar
  }()
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width-40, height: 74)
    layout.minimumLineSpacing = 8
    layout.minimumInteritemSpacing = 8
    layout.scrollDirection = .vertical
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "NewsCell")
    return collectionView
  }()
  
  private lazy var searchHistoryView: SearchHistoryView = {
    let view = SearchHistoryView()
    view.isHidden = true
    view.searchHistoryQueryHandler = { [weak self] query in
      guard let self = self else { return }
      view.isHidden = true
      self.searchBar.text = query
      self.viewModel.searchQuery = query
      self.viewModel.getNews { _ in
        self.fetchData(shouldResetCollectionView: true)
      }
    }
    return view
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationController?.navigationBar.isHidden = true
    configureViews()
    fetchData()
  }
  
  // MARK: - Helpers
  private func fetchData(shouldResetCollectionView: Bool = false){
    hideKeyboard()
    showLoading()
    viewModel.getNews { [weak self] _ in
      guard let self = self else { return }
      self.collectionView.reloadData()
      if shouldResetCollectionView {
        self.collectionView.setContentOffset(.zero, animated: false)
      }
      self.dismissLoading(willDismissQueue: true)
    }
  }
  
  private func configureViews(){
    view.addSubview(searchBar)
    searchBar.snp.makeConstraints { make in
      make.top.centerX.equalTo(view.safeAreaLayoutGuide)
      make.width.equalToSuperview().offset(-40)
      make.height.equalTo(30)
    }
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.top.equalTo(searchBar.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide)
    }
    
    view.addSubview(searchHistoryView)
    searchHistoryView.snp.makeConstraints { make in
      make.top.equalTo(searchBar.snp.bottom).offset(15)
      make.width.equalTo(searchBar).offset(-15)
      make.centerX.equalTo(searchBar)
      make.height.equalTo(400)
    }
  }
}

// MARK: - UISearchBarDelegate
extension NewsListViewController: UISearchBarDelegate {
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    if !isCurrentlyScrolling {
      searchHistoryView.isHidden = false
    }
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchHistoryView.isHidden = true
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    hideKeyboard()
    if viewModel.searchQuery == searchBar.text ?? ""{
      return
    }
    viewModel.searchQuery = searchBar.text ?? ""
    fetchData(shouldResetCollectionView: true)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    hideKeyboard()
    if viewModel.searchQuery == searchBar.text ?? ""{
      return
    }
    viewModel.searchQuery = ""
    fetchData(shouldResetCollectionView: true)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NewsListViewController: UICollectionViewDelegateFlowLayout {
  
  // Handle dynamic column numbers
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let isPortrait = UIScreen.main.bounds.height > UIScreen.main.bounds.width
    let columns: CGFloat = isPortrait ? 1.0 : 4.0
    let spacing: CGFloat = 8.0
    let width = (collectionView.bounds.width - (columns - 1) * spacing) / columns
    let height: CGFloat = 500
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 8.0
  }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension NewsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.news?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
    cell.data = viewModel.news?[indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let nextViewController = NewsDetailViewController(viewModel: viewModel, index: indexPath.row)
    showDetailViewController(nextViewController, sender: self)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    hideKeyboard()
    
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let scrollViewHeight = scrollView.frame.size.height
    
    let threshold: CGFloat = 100.0
    
    if offsetY > contentHeight - scrollViewHeight - threshold {
      fetchData()
    }
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    isCurrentlyScrolling = true
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    isCurrentlyScrolling = false
  }
  
}

