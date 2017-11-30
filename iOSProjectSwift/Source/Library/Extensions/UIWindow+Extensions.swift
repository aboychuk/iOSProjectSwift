//
//  UIWindow+Extensions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/30/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

extension UIWindow {
    
    static func window() -> UIWindow {
        return UIWindow.init(frame: UIScreen.main.bounds)
    }
    
    static func windowWithRootViewController(_ VC: UIViewController) -> UIWindow {
        let window = self.window()
        window.rootViewController = VC
        
        return window
    }
}
