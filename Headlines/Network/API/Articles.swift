//
//  Articles.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import Alamofire

enum Articles: APIRoute {
    case allArticles //normally we could pass in variables here, but hardcoded here for speed
    
    var path: String {
        switch self {
        case .allArticles: return "search?q=fintech&show-fields=main,body&api-key=\(AppConstants.apiKey)"
        }
    }
    
    var params: JSON? {
        return nil
    }
}
