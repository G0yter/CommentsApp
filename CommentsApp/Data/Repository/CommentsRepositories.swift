//
//  CommentsRepositories.swift
//  CommentsApp
//
//  Created by Vladyslav on 23.11.2022.
//

import Foundation

class CommentsRepository {
    
    public func getComments(lowerBound: Int, upperBound: Int) async -> [Comment] {
        let comments = await APIService.getComments(first: lowerBound, last: upperBound)
        return comments
    }
}
