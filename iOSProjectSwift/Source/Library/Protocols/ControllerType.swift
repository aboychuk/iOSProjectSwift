//
//  ControllerType.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/4/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import UIKit

protocol ControllerType {
    associatedtype ViewModelType: ViewModelProtocol
    
    func configure(with: ViewModelType)
    
    /// Factory method
    static func create(with: ViewModelType) -> UIViewController
}
