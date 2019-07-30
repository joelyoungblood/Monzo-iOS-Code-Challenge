//
//  CAGradientLayer.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    static func verticalGradient(withColors colors: [UIColor], andLocations locations: [NSNumber]) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.locations = locations
        gradient.colors = colors.map { $0.cgColor }
        gradient.contentsScale = UIScreen.main.scale
        gradient.rasterizationScale = UIScreen.main.scale
        gradient.shouldRasterize = true
        return gradient
    }
    
    static func horizontalGradient(withColors colors: [UIColor], andLocations locations: [NSNumber]) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.locations = locations
        gradient.colors = colors.map { $0.cgColor }
        gradient.contentsScale = UIScreen.main.scale
        gradient.rasterizationScale = UIScreen.main.scale
        gradient.shouldRasterize = true
        return gradient
    }
}
