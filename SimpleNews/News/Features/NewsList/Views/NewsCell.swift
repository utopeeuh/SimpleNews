//
//  NewsCell.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import UIKit

class NewsCell: UICollectionViewCell {
  
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
    snippetLbl.text = data?.snippet ?? ""
    dateLbl.text = (data?.pubDate ?? "N/A").convertDateStringFormat()
    layoutIfNeeded()
  }
  
  private func configureViews() {
    contentView.backgroundColor = .white
    
    let bottomBorder = UIView()
    bottomBorder.backgroundColor = .lightGray
    bottomBorder.translatesAutoresizingMaskIntoConstraints = false
    bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
    
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 8
    
    [imageView, titleLbl, snippetLbl, dateLbl, bottomBorder].forEach { subview in
      stack.addArrangedSubview(subview)
    }
    
    contentView.addSubview(stack)
    stack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
  }
  
  
  override func prepareForReuse() {
    imageView.image = nil
    titleLbl.text = nil
    snippetLbl.text = nil
    dateLbl.text = nil
  }
}
