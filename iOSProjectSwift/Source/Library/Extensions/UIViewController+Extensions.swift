//
//  UIViewController+Extensions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/5/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func presentAlertMessage(title: String, message: String) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK",
                                                    style: .default,
                                                    handler: nil))
        self.present(alertViewController, animated: true)
    }
    
    public func presentAlertError(title: String = "Error occured!", error: Error) {
        self.presentAlertMessage(title: title, message: error.localizedDescription)
    }
}
