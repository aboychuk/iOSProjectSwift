//
//  UIWindow+Extensions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/30/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

extension UIWindow {
    
    static func window(_ block: ((UIWindow) -> ())? = nil) -> UIWindow {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        block.map { $0(window) }
        
        return window
    }
}
