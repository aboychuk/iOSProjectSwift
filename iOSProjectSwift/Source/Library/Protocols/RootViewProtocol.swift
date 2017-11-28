//
//  RootViewProtocol.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/28/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

protocol RootView {
    associatedtype ViewType
    var rootView : ViewType? { get }
}

extension RootView where Self : UIViewController {
    var rootView : ViewType? { return self.viewIfLoaded as? ViewType }
}
