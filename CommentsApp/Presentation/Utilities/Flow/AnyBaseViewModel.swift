//
//  AnyBaseViewModel.swift
//  CommentsApp
//
//  Created by Vladyslav on 23.11.2022.
//

import Foundation
import Combine

protocol AnyState: Equatable {
  mutating func update(_ block: (inout Self) throws -> Void) rethrows
}

extension AnyState {
  mutating func update(_ block: (inout Self) throws -> Void) rethrows {
    try block(&self)
  }
}

protocol AnyBaseViewModel: ObservableObject {
  associatedtype State: AnyState
  associatedtype Action

  var state: State { get }
  var statePublisher: AnyPublisher<State, Never> { get }

  func action(_ action: Action)
}


class BaseViewModel<State: AnyState, Action, InjectedTypes>: AnyBaseViewModel {
  @Published public final var state: State

  final var statePublisher: AnyPublisher<State, Never> { $state.eraseToAnyPublisher() }
  final var cancellables = Set<AnyCancellable>()

  init(state: State) {
    self.state = state
  }

  func action(_ action: Action) {
    assertionFailure("The method should be implmented in subsclasses")
  }
}

