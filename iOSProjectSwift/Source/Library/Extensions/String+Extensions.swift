//
//  String+Extensions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

extension String {
    
    //MARK: - Class Functions
    
    static func removeIllegalCharactersFromString(_ string: String) -> String? {
        return string.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
    }
    
    static func toString<T>(from type : T.Type) -> String {
        return String(describing: type)
    }
}
