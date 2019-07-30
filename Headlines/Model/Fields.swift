//
//  Fields.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct Fields: Decodable {
    let imageUrl: URL?
    let body: String

    private enum CodingKeys: String, CodingKey {
        case imageUrl = "main"
        case body
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try container.decode(String.self, forKey: .imageUrl).url
        body = try container.decode(String.self, forKey: .body).strippingTags
    }
}
