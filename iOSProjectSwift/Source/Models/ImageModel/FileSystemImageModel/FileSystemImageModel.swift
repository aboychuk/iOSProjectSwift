//
//  FileSystemImageModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/9/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FilesystemImageModel: ImageModel {

    override func loadImage(with completionHandler: (UIImage?) -> ()) {
        let url = self.url.absoluteURL
        if let data = try? Data(contentsOf: url) {
            let image = UIImage.init(data: data)
            completionHandler(image)
        }
    }
}
