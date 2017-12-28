//
//  ImageModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/9/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

extension ImageModel : Hashable {
    
    //MARK: - Hashable
    
    static func ==(lhs: ImageModel, rhs: ImageModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

class ImageModel: Model {
    
    //MARK: - Properties
    
    var image: UIImage?
    let url: URL
    var hashValue: Int

    //MARK: - Initializers
    
    init(url: URL) {
        self.url = url
        self.hashValue = url.hashValue
        
        super.init()
    }
    
    deinit {
        ImageModelCache.sharedCache.removeModel(forKey: self.url)
    }
    
    //MARK: - Public Functions

    static func image(with url: URL) -> ImageModel? {
        let cache = ImageModelCache.sharedCache
        var imageModel = cache.model(forKey: url)
        
        if imageModel == nil {
            let model = url.isFileURL ? FilesystemImageModel(url: url) : InternetImageModel(url: url)
            cache.add(model: model, forKey: url)
            imageModel = model
        }
        
        return imageModel
    }
    
    //Method created for overriding do not call it directly
    func loadImage() {
        
    }
    
    override func performLoadingInBackground() {
        self.loadImage()
        DispatchQueue.main.async {
            self.state = self.image == nil ? .didFailLoading : .didLoad
        }
    }
}
