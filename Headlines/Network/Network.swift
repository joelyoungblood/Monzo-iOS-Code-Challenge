//
//  Network.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

typealias JSON = [String: Any]

final class Network {
    
    private static let reachability = NetworkReachabilityManager()!
    
    static func request(fromRoute route: APIRoute) -> Observable<Data> {
        if !reachability.isReachable {
            return Observable.error(NetworkError.noConnection)
        } else {
            return RxAlamofire.request(route).responseData().flatMap { response -> Observable<Data> in
                let result = response.0
                if result.statusCode == 200 {
                    let data = response.1
                    return Observable.just(data)
                } else {
                    return Observable.error(NetworkError.errorCode(code: result.statusCode))
                }
            }
        }
    }
}
