//
//  NewsDetailCell.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 01/09/23.
//

import Foundation
import UIKit

class NewsDetailCell: UICollectionViewCell {
  
  private lazy var titleLbl: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textColor = .black
    label.font = .boldSystemFont(ofSize: 18)
    return label
  }()
  
  private lazy var snippetLbl: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textColor = .black
    label.font = .systemFont(ofSize: 14)
    return label
  }()
  
  private lazy var dateLbl: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .left
    label.textColor = .lightGray
    label.font = .systemFont(ofSize: 12)
    return label
  }()
  
  private lazy var imageView: ImageLoader = {
    let imageView = ImageLoader()
    imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private lazy var favoriteBtn: UIButton = {
    let button = UIButton()
    button.setTitle("Add to favorites", for: .normal)
    button.setTitleColor(.systemPink, for: .normal)
    button.layer.borderColor = UIColor.systemPink.cgColor
    button.backgroundColor = .white
    button.layer.cornerRadius = 8
    button.layer.borderWidth = 1
    button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
    return button
  }()
  
  private let scrollView = UIScrollView()
  
  var favoriteTapHandler: (() -> Void)?
  
  var isFavorited = false {
    didSet {
      configureButton()
    }
  }
  
  var data: News? {
    didSet {
      configure()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    if let imageUrl = URL(string: data?.multimedia?.first?.url ?? "") {
      imageView.loadImageWithUrl(imageUrl)
    }
    
    titleLbl.text = data?.headline?.main ?? ""
    snippetLbl.text = data?.leadParagraph ?? ""
    dateLbl.text = (data?.pubDate ?? "N/A").convertDateStringFormat()
    scrollView.contentInset = .init(top: 0, left: 0, bottom: 40, right: 0)
  }
  
  private func configureButton() {
    if isFavorited {
      favoriteBtn.setTitle("Remove from favorites", for: .normal)
      favoriteBtn.setTitleColor(.white, for: .normal)
      favoriteBtn.backgroundColor = .systemPink
    } else {
      favoriteBtn.setTitle("Add to favorites", for: .normal)
      favoriteBtn.setTitleColor(.systemPink, for: .normal)
      favoriteBtn.backgroundColor = .white
    }
  }
  
  private func configureViews() {
    contentView.backgroundColor = .white
    
    scrollView.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
      imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40)
    ])
    
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 8
    
    [titleLbl, dateLbl, snippetLbl, favoriteBtn].forEach { subview in
      stack.addArrangedSubview(subview)
    }
    
    scrollView.addSubview(stack)
    stack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
      stack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      stack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
      stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ])
    
    favoriteBtn.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      favoriteBtn.widthAnchor.constraint(equalTo: stack.widthAnchor),
      favoriteBtn.heightAnchor.constraint(equalToConstant: 40)
    ])
    
    contentView.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
      scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  
  @objc func didTapFavorite(){
    isFavorited = !isFavorited
    favoriteTapHandler?()
  }
  
  override func prepareForReuse() {
    imageView.image = nil
  }
}
