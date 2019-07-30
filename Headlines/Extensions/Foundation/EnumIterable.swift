//
//  EnumIterable.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

#if swift(>=4.1.3)

extension CaseIterable {
    
    static var allValues: Self.AllCases {
        return allCases
    }
    
    static var count: Int {
        return allCases.count
    }
}

typealias EnumIterable = CaseIterable

#else

public protocol EnumIterable {
    associatedtype EnumType: Hashable, RawRepresentable = Self
    static var allValues: [EnumType] { get }
    static var rawValues: [EnumType.RawValue] { get }
}

public extension EnumIterable {
    
    fileprivate static func enumerated() -> AnyIterator<EnumType> {
        var i: Int = 0
        return AnyIterator {
            let next = withUnsafePointer(to: &i) {
                $0.withMemoryRebound(to: EnumType.self, capacity: 0) {
                    $0.pointee
                }
            }
            
            let nextValue: EnumType? = next.hashValue == i ? next : nil
            
            i += 1
            return nextValue
        }
    }
    
    static var allValues: [EnumType] {
        return enumerated().map { $0 }
    }
    
    static var rawValues: [EnumType.RawValue] {
        return allValues.map { $0.rawValue }
    }
}

public extension EnumIterable {
    
    static var count: Int {
        return allValues.count
    }
    
}

public protocol EnumSortable {
    var sortOrder: Int { get }
}

#endif
