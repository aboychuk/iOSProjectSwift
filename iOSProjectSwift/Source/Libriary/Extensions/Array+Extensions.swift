//
//  Array+Extensions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/16/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

extension Array {
    
    //MARK: - Class Functions
    
    mutating func move(from sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex == destinationIndex else {
            print("sourceIndex == destinationIndex")
            return
        }
        self.insert(self.remove(at: sourceIndex), at: destinationIndex)
    }
}
