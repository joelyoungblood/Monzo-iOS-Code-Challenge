//
//  Article.swift
//  Headlines
//
//  Created by Joshua Garnham on 09/05/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import Alamofire

@objcMembers final class Article: Object, Decodable, Identifiable {
    dynamic var id: String = ""
    dynamic var title: String = ""
    dynamic var body: String?
    dynamic var published: Date?
    dynamic var isFavourited = false
    @objc private dynamic var _rawImageURL: String?
    
    var imageURL: URL? {
        guard let rawImageURL = _rawImageURL else { return nil }
        return URL(string: rawImageURL)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case published = "webPublicationDate"
        case title = "webTitle"
        case fields
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        let fields = try container.decode(Fields.self, forKey: .fields)
        body = fields.body
        _rawImageURL = fields.imageUrl?.absoluteString
        
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
