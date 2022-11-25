//
//  Comment.swift
//  CommentsApp
//
//  Created by Vladyslav on 23.11.2022.
//

import Foundation

struct Comment: Codable, Hashable {
    let postId: Int
    let id: Int
    let name: String?
    let email: String?
    let body: String?
}
