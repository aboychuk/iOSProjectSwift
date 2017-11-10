//
//  ImageModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/9/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class ImageModel: Model {
    
    //MARK: - Properties
    
    var image: UIImage?
    let url: URL
    
    //MARK: - Initializers
    
    init(url: URL) {
        self.url = url
        
        super.init()
    }
    
    //MARK: - Public Methods

    func image(with url: URL) -> ImageModel? {
        let cache = ImageModelCache.sharedCache
        var imageModel = cache.model(for: url as AnyObject)
        if imageModel == nil {
            imageModel = url.isFileURL ? FilesystemImageModel(url: url) : InternetImageModel(url: url)
            cache.add(model: imageModel, for: url as AnyObject)
        }
        
        return imageModel as? ImageModel
    }
    
    //Method created for overriding do not call it directly
    func loadImage() -> UIImage? {
        return nil
    }
    
    override func performLoadingInBackground() {
       self.image = self.loadImage()
        if self.image == nil {
            self.state = .didFailLoading
        } else {
            self.state = .didLoad
        }
    }
}
