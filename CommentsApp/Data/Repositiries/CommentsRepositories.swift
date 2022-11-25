//
//  CommentsRepositories.swift
//  CommentsApp
//
//  Created by Vladyslav on 23.11.2022.
//

import Foundation

class CommentsRepositories {
    
    private let ten: Int = 10
    private var first: Int
    private var last: Int
    
    init(first: Int, last: Int) {
        self.first = first
        self.last = last
    }
    
    public func getComments() async -> [Comment] {
        let difference = last - first
        if difference < 10 { last = first + difference } else { last = first + 10 }
        let comments = await APIService.getComments(first: first, last: last)
        return comments
    }
    
}
