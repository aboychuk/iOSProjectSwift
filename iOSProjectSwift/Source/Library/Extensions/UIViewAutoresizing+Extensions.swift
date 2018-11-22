//
//  UIViewAutoresizing+Extensions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/29/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

extension UIView.AutoresizingMask {
    public static var autoresizeWithFixedPosition : UIView.AutoresizingMask {
        return [
        .flexibleLeftMargin,
        .flexibleWidth,
        .flexibleRightMargin,
        .flexibleTopMargin,
        .flexibleHeight,
        .flexibleBottomMargin
        ]
    }
    
    public static var autoresize : UIView.AutoresizingMask {
        return [
        .flexibleWidth,
        .flexibleHeight
        ]
    }
}
