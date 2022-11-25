//
//  UIView+AddSubviews.swift
//  CommentsApp
//
//  Created by Vladyslav on 23.11.2022.
//

import Foundation
import UIKit

extension UIView {

  /**
   * Adds subview performing the next steps:
   *   1. Set translatesAutoresizingMaskIntoConstraints to false
   *   2. Activate constraints
   */
  func addSubview(_ view: UIView, @AutolayoutBuilder constraints: () -> [NSLayoutConstraint]) {
    addSubview(view)

    view.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate(constraints())
  }

  /**
   * Adds subview to a view by the next steps:
   *   1. Set translatesAutoresizingMaskIntoConstraints to false
   *   2. Activate top, bottom, leading and trailing constraints and set their constant equal to offset
   */
  func addSubviewFillingToEdges(_ view: UIView, offset: CGFloat = 0.0) {
    addSubview(view, constraints: {
      view.topAnchor.constraint(equalTo: topAnchor, constant: offset)
      view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset)
      view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset)
      view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset)
    })
  }

  /**
   * Adds subview to a view by the next steps:
   *   1. Set translatesAutoresizingMaskIntoConstraints to false
   *   2. Activate top, bottom, leading and trailing constraints and set their constant equal to inset values
   */
  func addSubview(_ view: UIView, insets: UIEdgeInsets) {
    addSubview(view, constraints: {
      view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top)
      view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left)
      view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
      view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
    })
  }

  /**
   * Adds multiple views to a view
   */
  func addSubview(_ views: UIView...) {
    views.forEach({ addSubview($0) })
  }

  /**
   * Adds multiple views to a view
   */
  func addSubview(_ views: [UIView]) {
    views.forEach({ addSubview($0) })
  }

  var snapshot: UIImage {
    UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
    let context = UIGraphicsGetCurrentContext()
    layer.render(in: context!)
    let snapshot = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return snapshot
  }
}

