//
//  UIFont.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func superclarendon(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Superclarendon", size: ofSize)!
    }
    
    static func superclarendonBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Superclarendon-Bold", size: ofSize)!
    }
    
    static func baskerville(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Baskerville", size: ofSize)!
    }
    
    static func sfUISemibold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Semibold", size: ofSize)!
    }
}
