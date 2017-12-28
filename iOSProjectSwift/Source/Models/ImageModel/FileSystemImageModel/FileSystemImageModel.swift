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
        return FileManager.documentsPathAppend(folder: Constants.folderName)
    }
    
    var imageName: String? {
        return String.removeIllegalCharactersFromString(self.url.absoluteString)
    }
    
    //MARK: - Overrided Functions

    override func loadImage() {
        self.imagePath
            .map { FileManager.default.contents(atPath: $0)
            .map { self.image = UIImage(data: $0) }
        }
    }
}
