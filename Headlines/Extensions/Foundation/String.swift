//
//  String.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

extension String {
    var strippingTags: String {
        var result = self.replacingOccurrences(of: "</p> <p>", with: "\n\n") as NSString
        
        var range = result.range(of: "<[^>]+>", options: .regularExpression)
        while range.location != NSNotFound {
            result = result.replacingCharacters(in: range, with: "") as NSString
            range = result.range(of: "<[^>]+>", options: .regularExpression)
        }
        
        return result as String
    }
    
    var url: URL? {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return nil }
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: (self as NSString).length))
        return matches.first?.url
    }
}
