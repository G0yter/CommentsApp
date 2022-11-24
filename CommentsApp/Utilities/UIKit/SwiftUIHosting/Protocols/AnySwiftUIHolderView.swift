//
//  AnySwiftUIHolderView.swift
//  CommentsApp
//
//  Created by Vladyslav Liubov on 23.11.2022.
//

import Foundation
import SwiftUI
import UIKit

protocol AnySwiftUIHolderView: AnyObject {
  var swiftUIControllers: [String: UIViewController] { get set }
}

extension AnySwiftUIHolderView {

  func makeHostingController<Content: View>(@ViewBuilder view: () -> Content,
                                            by id: String = UUID().uuidString) -> (String, UIViewController) {
    let view = view()
    let controller = UIHostingController(rootView: view)

    return (id, controller)
  }

  /**
   * Use this method to remove a SwiftUI view as controller
   */
  func remove(_ id: String) {
    let controller = swiftUIControllers.removeValue(forKey: id)

    controller?.view.removeFromSuperview()
    controller?.removeFromParent()
  }

}

extension AnySwiftUIHolderView where Self: BaseViewController {

  func add<Content: View>(@ViewBuilder view: () -> Content,
                          by id: String = UUID().uuidString,
                          holderView: UIView,
                          addView: (_ holderView: UIView, _ contentView: UIView) -> Void) {
    let (id, controller) = makeHostingController(view: view, by: id)

    add(controller: controller, by: id)

    addView(holderView, controller.view)
  }

  func add(controller: UIViewController, by id: String = UUID().uuidString) {
      add(viewController: controller)

    assert(swiftUIControllers[id] == nil, "Remove a controller to remove view")

    swiftUIControllers[id] = controller
  }
}

extension AnySwiftUIHolderView where Self: UIView {

  /**
   * Adds SwiftUIView on a View
   *
   * - Warning: Doesn't set any parent viewController
   */
  func add<Content: View>(@ViewBuilder view: () -> Content,
                          by id: String = UUID().uuidString,
                          holderView: UIView,
                          addView: (_ holderView: UIView, _ contentView: UIView) -> Void) {
    let view = view()
    let controller = UIHostingController(rootView: view)

    addView(holderView, controller.view)

    assert(swiftUIControllers[id] == nil, "Remove a controller to remove view")

    swiftUIControllers[id] = controller
  }

}
