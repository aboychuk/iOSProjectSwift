//
//  UIViewAutoresizing+Extensions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/29/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

extension UIViewAutoresizing {
    public static var autoresizeWithFixedPosition : UIViewAutoresizing {
        return [
        .flexibleLeftMargin,
        .flexibleWidth,
        .flexibleRightMargin,
        .flexibleTopMargin,
        .flexibleHeight,
        .flexibleBottomMargin
        ]
    }
    
    public static var autoresize : UIViewAutoresizing {
        return [
        .flexibleWidth,
        .flexibleHeight
        ]
    }
}
