//
//  FileSystemImageModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/9/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FilesystemImageModel: ImageModel {
    
    //MARK: - Properties
    
    var imagePath: String? {
        return FileManager.documentsPath
    }
    
    //MARK: - Overrided Methods

    override func loadImage() {
        let url = self.url.absoluteURL
        if let data = try? Data(contentsOf: url) 
            let image = UIImage.init(data: data)
            self.image = image
        }
    }
}
