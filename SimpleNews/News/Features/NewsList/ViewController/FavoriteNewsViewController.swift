//
//  FavoriteNewsViewController.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 01/09/23.
//

import Foundation
import UIKit

class FavoriteNewsViewController: UIViewController {
  
  // MARK: - Properties
  private let viewModel = NewsViewModel()
  
  // MARK: - UI Properties
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
    collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "FavoriteCell")
    return collectionView
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationController?.navigationBar.isHidden = true
    configureViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.getFavoriteNews()
    collectionView.reloadData()
  }
  
  // MARK: - Helpers
  private func configureViews() {
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteNewsViewController: UICollectionViewDelegateFlowLayout {
  
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
extension FavoriteNewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.favoriteNews.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! NewsCell
    cell.data = viewModel.favoriteNews[indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let nextViewController = NewsDetailViewController(viewModel: viewModel, index: indexPath.row, isFavorites: true)
    showDetailViewController(nextViewController, sender: self)
  }
}

