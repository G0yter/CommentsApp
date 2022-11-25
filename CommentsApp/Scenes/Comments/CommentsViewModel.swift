//
//  CommentsViewModel.swift
//  CommentsApp
//
//  Created by Vladyslav Liubov on 23.11.2022.
//

import Combine
import SwiftUI

class CommentsViewModel: BaseViewModel<CommentsViewModel.State, CommentsViewModel.Action, Never> {
    
    enum Action {
        //Screen
        case back
        //Update
        case updateComments(comments: [Comment], bound: Int, first: String, last: String)
    }
    
    struct State: AnyState {
        static func == (lhs: CommentsViewModel.State, rhs: CommentsViewModel.State) -> Bool {
            true
        }
        
        enum Screen: Equatable {
            case back
        }
        
        public let ten: Int = 10
        
        public fileprivate(set) var showedScreen: Screen?
        public fileprivate(set) var comments: [Comment] = []
        
        public fileprivate(set) var first: Int = 0
        public fileprivate(set) var last: Int = 0
        public fileprivate(set) var bound: Int = 0
        
        public fileprivate(set) var showLoading: Bool = false
        
        init() {}
        
    }
    
    override func action(_ action: Action) {
        
        switch action {
        case let.updateComments(comments, bound, first, last):
            state.comments = comments
            state.bound = bound
            state.first = Int(first)!
            state.last = Int(last)!
            if bound > state.ten {
                state.showLoading = true
            }
        case .back:
            state.showedScreen = nil
            state.showedScreen = .back
        }
    }
    
    @MainActor
    func getComments() {
        state.bound -= state.ten
        var last: Int = state.last
        if state.bound > state.ten {
            state.showLoading = true
            state.first += state.ten
            last = state.first + state.ten
        } else {
            state.first += state.ten
        }
        
        Task {
            let comments = await APIService.getComments(first: state.first, last: last)
            state.comments += comments
            if state.bound < state.ten {
                state.showLoading = false
            }
        }
    }
}
