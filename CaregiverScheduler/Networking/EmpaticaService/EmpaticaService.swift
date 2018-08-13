//
//  MangaEdenService.swift
//  RxMoya
//
//  Created by Jean Raphael on 04/07/2018.
//  Copyright © 2018 Jean Raphael. All rights reserved.
//

import Foundation
import Moya

enum EmpaticaService {
    case users(seed: String, results: Int)
}

// MARK: - TargetType Protocol Implementation

extension EmpaticaService: TargetType {
    var baseURL: URL { return URL(string: "https://randomuser.me")! }
    
    var path: String {
        switch self {
        case .users(_ , _):
            return "/api"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .users:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .users(let seed , let results):
            return .requestParameters(parameters: ["seed": seed, "results": results], encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .users(let username, let password):
            return  "{\"username\": \(username), \"password\": \"\(password)\"}".utf8Encoded
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

// MARK: - Helpers

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
