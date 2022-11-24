//
//  AutolayoutBuilder.swift
//  CommentsApp
//
//  Created by Vladyslav Liubov on 23.11.2022.
//

import Foundation
import UIKit

protocol LayoutGroup {
  var constraints: [NSLayoutConstraint] { get }
}

extension NSLayoutConstraint: LayoutGroup {
  var constraints: [NSLayoutConstraint] { [self] }
}

extension Array: LayoutGroup where Element == NSLayoutConstraint {
  var constraints: [NSLayoutConstraint] { self }
}

/**
 * A simple result builder, which allows to merge constraints into array.
 *
 * So you can write:
 *
 * NSLayoutBuilder.activate([
 *   view.widthAnchor.constraint(equalToConstant: 10)
 *
 *   [leadingConstraint, bottomConstraint]
 * ])
 */
@resultBuilder
struct AutolayoutBuilder {
  static func buildBlock(_ components: LayoutGroup...) -> [NSLayoutConstraint] {
    components.flatMap { $0.constraints }
  }
  static func buildOptional(_ component: [LayoutGroup]?) -> [NSLayoutConstraint] {
    component?.flatMap { $0.constraints } ?? []
  }
  static func buildEither(first component: [LayoutGroup]) -> [NSLayoutConstraint] {
    component.flatMap { $0.constraints }
  }

  static func buildEither(second component: [LayoutGroup]) -> [NSLayoutConstraint] {
    component.flatMap { $0.constraints }
  }
}

extension NSLayoutConstraint {

  /**
   * Use to activate constraints for a view
   */
  static func activate(@AutolayoutBuilder constraints: () -> [NSLayoutConstraint]) {
    activate(constraints())
  }

  /**
   * Use to activate constraints for a view
   */
  func activate(@AutolayoutBuilder constraints: () -> [NSLayoutConstraint]) {
    Self.activate(constraints())
  }

}


