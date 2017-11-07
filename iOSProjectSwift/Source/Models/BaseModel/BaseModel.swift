//
//  BaseModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/3/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

enum ModelState {
    case didUnload
    case willLoad
    case didLoad
    case didFailLoading
}

class BaseModel: ObservableObject {
    func load() {
        let state = self.state
        if state == .willLoad || state == .didLoad {
        }
    }
}
