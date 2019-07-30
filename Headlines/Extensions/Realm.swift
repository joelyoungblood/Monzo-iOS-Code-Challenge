//
//  Realm.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    func safeAdd<S: Sequence>(_ objects: S) where S.Iterator.Element: Object {
        objects.forEach {
            safeAdd($0)
        }
    }
    
    func safeAdd(_ object: Object) {
        guard !object.isInvalidated else {
            print("Attempt to add deleted object of type '\(object.objectSchema.className)' to Realm.")
            return
        }
        
        let update = object is Identifiable
        
        if update && object.objectSchema.primaryKeyProperty == nil {
            print("'\(object.objectSchema.className)' does not have a primary key and can not be updated.")
            return
        }
        
        add(object, update: .all)
    }
    
    static func performWrite(_ block: (_ realm: Realm) -> Void) {
        do {
            let realm = try Realm()
            
            do {
                try realm.write {
                    block(realm)
                }
            } catch {
                print("[Realm] An error occurred during write transaction: \(error)")
            }
            
        } catch {
            print("[Realm] Failed to instantiate Realm.")
        }
    }
}

protocol Identifiable {
    var id: String { get set }
}

protocol Realmable { }

extension Realmable where Self: Object {
    
    static func fetchAllWhere(key: String, matchesValue value: String) -> Results<Self> {
        let predicate = NSPredicate(format: "\(key) == \(value)")
        return fetchAll(predicate: predicate)
    }
    
    static func fetchAll(predicate: NSPredicate? = nil) -> Results<Self> {
        let realm = try! Realm()
        if let predicate = predicate {
            return realm.objects(Self.self).filter(predicate)
        }
        return realm.objects(Self.self)
    }
    
    static func fetchFirst(predicate: NSPredicate? = nil) -> Self? {
        return fetchAll(predicate: predicate).first
    }
    
    static func fetchFirstWhere(key: String, matchesValue value: String) -> Self? {
        let predicate = NSPredicate(format: "\(key) == \(value)")
        return fetchFirst(predicate: predicate)
    }
}
