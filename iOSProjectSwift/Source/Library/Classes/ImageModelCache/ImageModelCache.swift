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
    
    func add(model: WeakHashable<ImageModel>, forKey: URL) {
        synchronized(self) { self.cachedObjects.updateValue(model, forKey: forKey) }
    }
    
    func removeModel(forKey: URL) {
        synchronized(self) { self.cachedObjects.removeValue(forKey: forKey) }
    }
    
    func model(forKey: URL) -> ImageModel? {
        return synchronized(self) { return self.cachedObjects[forKey]?.object }
    }
}
