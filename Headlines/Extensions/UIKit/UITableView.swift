//
//  UITableView.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(_ cell: AnyClass) {
        self.register(cell.self, forCellReuseIdentifier: String(describing: cell))
    }
    
    func register(nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func registerHeaderFooter(_ view: AnyClass) {
        self.register(view.self, forHeaderFooterViewReuseIdentifier: String(describing: view))
    }
    
    func registerHeaderFooterNib(_ nib: AnyClass) {
        let nibObject = UINib(nibName: String(describing: nib), bundle: nil)
        self.register(nibObject, forHeaderFooterViewReuseIdentifier: String(describing: nib))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: ReusableView {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue UITableViewHeaderFooterView with identifier: \(T.reuseIdentifier)")
        }
        return view
    }
}

protocol ReusableView: class { }

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
