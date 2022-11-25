//
//  APIEndpoints.swift
//  CommentsApp
//
//  Created by Vladyslav on 23.11.2022.
//

import Foundation

enum APIEndpoint {
    case comments(start: Int, end: Int)
    
    var url: String {
        switch self {
        case let .comments(start,end):
            return "\(APIService.baseURL)/comments?_start=\(start)&_end=\(end)"
        }
    }
}
