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
    
    //MARK: - Public Functions

    func image(with url: URL) -> ImageModel? {
        let cache = ImageModelCache.sharedCache
        guard let imageModel = cache.model(forKey: url as AnyObject) else { return nil }
        imageModel = url.isFileURL ? FilesystemImageModel(url: url) : InternetImageModel(url: url)
        cache.add(model: imageModel, forKey: url as AnyObject)
        
        return imageModel as? ImageModel
    }
    
    //Method created for overriding do not call it directly
    func loadImage() {
        
    }
    
    override func performLoadingInBackground() {
        self.loadImage()
        self.state = self.image == nil ? .didFailLoading : .didLoad
    }
}
