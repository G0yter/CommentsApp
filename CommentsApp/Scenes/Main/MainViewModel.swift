//
//  MainViewModel.swift
//  CommentsApp
//
//  Created by Vladyslav Liubov on 23.11.2022.
//

import Combine
import SwiftUI

class MainViewModel: BaseViewModel<MainViewModel.State, MainViewModel.Action, Never> {
    
    enum Action {
        case updateFirstNumber(String)
        case updateSecondNumber(String)
        case updateShowAlert(Bool)
        case cancelDownloadComments
    }
    
    struct State: AnyState {
        static func == (lhs: MainViewModel.State, rhs: MainViewModel.State) -> Bool {
            true
        }
        
        enum Screen: Equatable {
            case showCommentsScreen
        }
        //Screen
        public fileprivate(set) var showedScreen: Screen?
        //Shows
        public fileprivate(set) var validNumbers = false
        public fileprivate(set) var indicatorShow = false
        //Numbers
        public fileprivate(set) var firstNumber: String = ""
        public fileprivate(set) var secondNumber: String = ""
        //Comments
        public fileprivate(set) var comments: [Comment] = []
        public fileprivate(set) var bound: Int = 0
        //Task
        public fileprivate(set) var task: Task<Void, Never>?
        //Alert
        public fileprivate(set) var alertText: String = ""
        public fileprivate(set) var showAlert: Bool = false
        
        init() {}
        
    }
    
    override func action(_ action: Action) {
        switch action {
        case let .updateFirstNumber(input):
            state.firstNumber = input
            if !input.isEmpty { checkValidBound() } else { state.validNumbers = false }
        case let .updateSecondNumber(input):
            state.secondNumber = input
            if !input.isEmpty { checkValidBound() } else { state.validNumbers = false }
        case let .updateShowAlert(bool):
            state.showAlert = bool
        case .cancelDownloadComments:
            state.task?.cancel()
        }
    }
    
    func checkValidBound() {
        guard Int(state.firstNumber) != nil && Int(state.secondNumber) != nil else { return }
        if Int(state.firstNumber)! < Int(state.secondNumber)! {
            state.bound = Int(state.secondNumber)! - Int(state.firstNumber)!
            state.validNumbers = true
        } else {
            state.validNumbers = false
        }
    }
    
    @MainActor
    func getComments() {
        state.indicatorShow = true
        state.task = Task {
            
            try? await Task.sleep(nanoseconds: 3_000_000_000) 
            
            let first: Int = Int(state.firstNumber)!
            var last: Int = Int(state.secondNumber)!
            let difference = last - first
            if difference < 10 { last = first + difference } else { last = first + 10 }
            
            let comments = await APIService.getComments(first: first, last: last)
            if Task.isCancelled {
                state.indicatorShow = false
            } else {
                state.indicatorShow = false
                if comments != [] {
                    state.comments = comments
                    state.showedScreen = nil
                    state.showedScreen = .showCommentsScreen
                } else {
                    state.alertText = "No comments"
                    state.showAlert = true
                }
            }
        }
    }
}
