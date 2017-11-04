//
//  BaseModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/3/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

enum ModelState {
    case modelDidUnload
    case modelWillLoad
    case modelDidLoad
    case modelFailLoad
}

class BaseModel: NSObject {
    func load() {
        let state = ModelState
    }
}
