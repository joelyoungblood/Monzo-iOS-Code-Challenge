//
//  UIViewController.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

protocol Alertable {
    
    func showAlert(for error: HeadlinesError)
    func showAlert(for message: String)
    func showAlert(with title: String, message: String)
}

extension Alertable where Self: UIViewController {
    
    func showAlert(for error: HeadlinesError) {
        let alertController = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(for message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
