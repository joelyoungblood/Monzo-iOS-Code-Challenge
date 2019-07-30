//
//  APIRoute.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRoute: URLRequestConvertible {
    var root: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
    var params: JSON? { get }
}

extension APIRoute {
    
    //We go through this step so that we could switch our root url depending on the environment, eg. prod, dev, test etc, as well as it's nice to have the option if there are differant API roots
    var root: String {
        return AppConstants.rootUrl
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: root + path) else { throw NetworkError.formationError(url: root + path) }
        print(url.absoluteString)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
