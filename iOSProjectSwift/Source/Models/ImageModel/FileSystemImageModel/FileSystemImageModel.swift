//
//  FileSystemImageModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/9/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FilesystemImageModel: ImageModel {
    
    //MARK: - Constants
    
    struct Constants {
        static let folderName = "images"
    }
    
    //MARK: - Properties
    
    var imagePath: String? {
        var path = FileManager.documentsPath()
        path?.append(Constants.folderName)
        
        return path
    }
    
    var imageName: String? {
        return String.removeIllegalCharactersFromString(self.url.absoluteString)
    }
    
    //MARK: - Overrided Methods

    override func loadImage() {
        if let data = FileManager.default.contents(atPath: self.imagePath!) {
            self.image = UIImage(data: data)
        }
    }
}
