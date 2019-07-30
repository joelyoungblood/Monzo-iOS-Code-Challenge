//
//  Request.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import RxSwift

final class Request {
    
    private static let decoder = JSONDecoder()
    
    static func allArticles() -> Observable<[Article]> {
        return Network.request(fromRoute: Articles.allArticles).map { data in
            do {
                let decodedResponse = try decoder.decode(Response.self, from: data)
                switch decodedResponse.status {
                case .success:
                    return decodedResponse.articles
                case .failure:
                    throw NetworkError.invalidStatus
                }
            } catch let error {
                throw DecodeError<Article>.decode(error: error)
            }
        }
    }
    
}
