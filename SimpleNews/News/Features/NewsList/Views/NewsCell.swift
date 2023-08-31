//
//  NewsCell.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import UIKit
import SnapKit

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
    } else {
      imageView.image = ImagesUI.placeholder.getImage()
    }
    titleLbl.text = data?.headline?.main ?? ""
    snippetLbl.text = data?.snippet ?? ""
    dateLbl.text = (data?.pubDate ?? "N/A").convertDateStringFormat()
  }
  
  private func configureViews() {
    contentView.backgroundColor = .white
    
    let bottomBorder = UIView()
    bottomBorder.backgroundColor = .lightGray
    bottomBorder.snp.makeConstraints { make in
      make.height.equalTo(1)
    }
    
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 8
    
    [imageView, titleLbl, snippetLbl, dateLbl, bottomBorder].forEach { stack.addArrangedSubview($0)}
    contentView.addSubview(stack)
    stack.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.bottom.equalToSuperview().inset(8)
    }
  }
  
  override func prepareForReuse() {
    imageView.image = nil
  }
}
