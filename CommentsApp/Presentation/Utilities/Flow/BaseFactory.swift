//
//  BaseFactory.swift
//  CommentsApp
//
//  Created by Vladyslav on 23.11.2022.
//

import SwiftUI

protocol AnyMediaSource {}
protocol AnyMediaSourceProvider {}

protocol AnyFactoryEnvironment {
  associatedtype Factory

  var factory: Factory! { get }
}

class BaseFactory {
  public enum ViewType {
    case imageView(AnyMediaSourceProvider)
  }
  
  public init() {}
  
  open func make(_ type: ViewType) -> AnyView {
    fatalError()
  }
}

