//
//  ImageModelCache.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/8/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

class ImageModelCache {
    
    //MARK: - Properties
    
    static let sharedCache = ImageModelCache()
    var cachedObjects = [URL : WeakHashable<ImageModel>]()
    
    //MARK: - Initializations
    
    private init () { }
    
    //MARK: - Public Functions
    
    func add(model: ImageModel, forKey key: URL) {
        synchronized(self) { _ = self.cachedObjects.updateValue(WeakHashable(object: model), forKey: key) }
    }
    
    func removeModel(forKey key: URL) {
        synchronized(self) { _ = self.cachedObjects.removeValue(forKey: key) }
    }
    
    func model(forKey key: URL) -> ImageModel? {
        return synchronized(self) { return self.cachedObjects[key]?.object }
    }
}
