//
//  FileSystemImageService.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/21/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import UIKit.UIImage

class FileSystemImageService: ImageServiceType {
    
    // MARK: - Properties
    
    internal var url: URL
    var image: UIImage?
    
    // MARK: - Init
    
    init(url: URL) {
        self.url = url
    }
    
    // MARK: - Public
    
    func getImage() {
        self.imagePath
            .map { FileManager.default.contents(atPath: $0)
            .map { self.image = UIImage(data: $0) }}
    }
    
    // MARK: - Error
    
    enum ImageFSServiceError: Error {
        case noFileInFileSystem
    }
}
