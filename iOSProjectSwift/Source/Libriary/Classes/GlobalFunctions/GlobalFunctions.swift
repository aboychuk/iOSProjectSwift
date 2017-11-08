//
//  GlobalFunctions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/8/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

func synchronized(_ lock: Any, block: () -> ()) {
    objc_sync_enter(lock)
    block()
    objc_sync_exit(lock)
}
