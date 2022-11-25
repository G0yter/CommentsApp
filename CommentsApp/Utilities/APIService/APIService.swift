//
//  APIService.swift
//  CommentsApp
//
//  Created by Vladyslav Liubov on 23.11.2022.
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


class APIService {
    static let shared = APIService()
    
    static let baseURL = "https://jsonplaceholder.typicode.com"
    static let methodGet = "GET"
    static let contentValueHeader = "Content-Type"
    static let acceptValueHeader = "Accept"
    static let applicationJson = "application/json"
    
    static func getComments(first: Int, last: Int) async -> [Comment] {
        let url = URL(string: "\(APIEndpoint.comments(start: first, end: last).url)")!
        var request = URLRequest(url: url)
        request.httpMethod = methodGet
        request.addValue(applicationJson, forHTTPHeaderField: contentValueHeader)
        request.addValue(applicationJson, forHTTPHeaderField: acceptValueHeader)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let model = try JSONDecoder().decode([Comment].self, from: data)
            return model
            
        }
        catch {
            return []
        }
    }
}
