//
//  Response.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

enum ResponseStatus: String {
    case success
    case failure
    
    init(statusString: String) {
        switch statusString {
            case "ok": self = .success
            default: self = .failure
        }
    }
}

//I'd normally handle this with generics, but for time reasons I'm hardcoding the result type to [Article]
//I would also use this model to handle any pagination
struct Response: Decodable {
    let status: ResponseStatus
    let articles: [Article]
    
    private enum CodingKeys: String, CodingKey {
        case response
        case status
        case articles = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let root = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        let statusString = try root.decode(String.self, forKey: .status)
        status = ResponseStatus(statusString: statusString)
        articles = try root.decode([Article].self, forKey: .articles)
    }
}
