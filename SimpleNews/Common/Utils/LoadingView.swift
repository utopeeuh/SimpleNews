//
//  LoadingView.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import UIKit
import SnapKit

enum ViewTags {
  static let activityView = 98
  static let backgroundCover = 99
}

public class LoadingView {
  
  private var loadingQueueCounter: Int {
    var counter = 0
    currentWindow { window in
      window.subviews.forEach { view in
        if view.isKind(of: QueueView.self) {
          counter += 1
        }
      }
    }
    return counter
  }
  
  private let widthHeight: CGFloat = 220
  
  private lazy var activityView : UIActivityIndicatorView = {
    let activityView = UIActivityIndicatorView()
    activityView.color = .darkGray
    activityView.alpha = 0.3
    activityView.isHidden = true
    activityView.tag = ViewTags.activityView
    return activityView
  }()
  
  private var backgroundCover: UIView
  private let queueView = QueueView()
  
  public init() {
    backgroundCover = UIView()
    backgroundCover.backgroundColor = .clear
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
  }
  
  private func animateView() {
    UIViewPropertyAnimator(duration: 0.3, dampingRatio: 0.6) { [weak self] () in
      guard let self = self else { return }
      self.activityView.isHidden = false
      self.activityView.alpha = 1
      self.activityView.transform = .identity
    }.startAnimation()
  }
  
  public func show(backgroundColor: UIColor = .black.withAlphaComponent(0.25)) {
    
    currentWindow { window in
      window.addSubview(queueView)
    }
    
    if loadingQueueCounter > 1 {
      return
    }

    NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(reloadAnimation), name: UIApplication.willEnterForegroundNotification, object: nil)

    activityView.startAnimating()
    currentWindow { window in
      backgroundCover = UIView(frame: window.bounds)
      backgroundCover.backgroundColor = backgroundColor
      window.addSubview(backgroundCover)
      backgroundCover.addSubview(activityView)
      backgroundCover.tag = ViewTags.backgroundCover
      
      activityView.snp.makeConstraints { make in
        make.size.equalTo(widthHeight)
        make.centerX.centerY.equalToSuperview()
      }

      animateView()
    }
  }
  
  func currentWindow(window: (UIWindow) -> Void) {
    if #available(iOS 13.0, *) {
      let activeWindow = UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        .first { $0.isKeyWindow }
      if let activeWindow = activeWindow {
          window(activeWindow)
      }
    } else {
      let activeWindow = UIApplication.shared.keyWindow
      if let activeWindow = activeWindow {
          window(activeWindow)
      }
    }
  }
  
  public func dismiss(willDismissQueue: Bool) {
    currentWindow { window in
      if willDismissQueue {
        window.subviews.forEach { view in
          if view.isKind(of: QueueView.self) {
            view.removeFromSuperview()
          }
        }
      } else {
        window.subviews.first(where: {$0.isKind(of: QueueView.self)})?.removeFromSuperview()
      }
      if loadingQueueCounter == 0 {
        guard let animationView = window.viewWithTag(ViewTags.activityView),
              let backgroundCover = window.viewWithTag(ViewTags.backgroundCover)
        else { return }
        animationView.removeFromSuperview()
        backgroundCover.removeFromSuperview()
      }
    }
  }
  
  @objc func reloadAnimation() {
    activityView.startAnimating()
  }
}

// This class is only used for identifying the stack of uiviews
// that represent the queue for LoadingView in the window
fileprivate class QueueView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
