//
//  FileManager+Extensions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

extension FileManager {
    
    //MARK: - Class Functions
    
    static func documentsPath() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths.first
    }
    
    static func documentsPathAppend(folder: String) -> String? {
        return FileManager.documentsPath()?.appending(folder)
    }
}
