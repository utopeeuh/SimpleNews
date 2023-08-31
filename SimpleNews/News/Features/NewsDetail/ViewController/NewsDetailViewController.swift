//
//  ViewController.swift
//  Simple News
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import UIKit
import SnapKit

class NewsDetailViewController: UIViewController {
  
  // MARK: - Properties
  var viewModel : NewsViewModel
  var index = 0
  
  // MARK: - UI Properties
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = UIScreen.main.bounds.size
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    layout.scrollDirection = .horizontal
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.alpha = 0
    collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "NewsCell")
    return collectionView
  }()
  
  // MARK: - Init
  init(viewModel: NewsViewModel, index: Int = 0) {
    self.viewModel = viewModel
    self.index = index
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureViews()
    
    DispatchQueue.main.asyncAfter(deadline: .now()+0.3) { [weak self] in
      self?.collectionView.scrollToItem(at: .init(row: self?.index ?? 0, section: 0), at: .centeredHorizontally, animated: false)
      UIView.animate(withDuration: 0.3) {
        self?.collectionView.alpha = 1
      }
    }
  }
  
  // MARK: - Helpers
  private func configureViews(){
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func scrollToNearestCell() {
    let collectionViewBounds = collectionView.bounds
    let centerOffsetX = collectionViewBounds.size.width / 2
    let contentOffset = collectionView.contentOffset.x + centerOffsetX
    
    if let indexPath = collectionView.indexPathForItem(at: CGPoint(x: contentOffset, y: collectionViewBounds.midY)) {
      collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
  }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension NewsDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.news?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
    cell.data = viewModel.news?[indexPath.row]
    return cell
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetX = scrollView.contentOffset.x
    let contentWidth = scrollView.contentSize.width
    let scrollViewWidth = scrollView.frame.size.width
    
    let threshold: CGFloat = 100.0
    
    if offsetX > contentWidth - scrollViewWidth - threshold {
      viewModel.getNews { [weak self] _ in
        self?.collectionView.reloadData()
      }
    }
  }
  
  func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    scrollToNearestCell()
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    scrollToNearestCell()
  }
}
