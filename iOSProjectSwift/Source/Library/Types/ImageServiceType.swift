//
//  ImageServiceType.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/21/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import UIKit

protocol ImageServiceType {
    var url: URL { get set }
    var imagePath: String? { get }
    var isSaved: Bool { get }
    var image: UIImage? { get set }
    
    func getImage()
}

extension ImageServiceType {
    
    // MARK: - Properties
    
    var imagePath: String? {
        var path = FileManager.documentsPathAppend(folder: Constants.folderName)
        path?.append(self.imageName ?? Constants.imageName)
        
        return path
    }
    
    var isSaved: Bool {
        guard let path = self.imagePath else { return false }
        
        return FileManager.default.fileExists(atPath: path)
    }
    
    internal var imageName: String? {
        return String.removeIllegalCharactersFromString(self.url.absoluteString)
    }
}

// MARK: - Constants

fileprivate enum Constants {
    static let folderName = "images"
    static let imageName = "ImageName"
}

