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
    var cachedObjects: NSMapTable<AnyObject, AnyObject> = NSMapTable.strongToWeakObjects()
    
    //MARK: - Initializations
    
    private init () { }
    
    //MARK: - Public Functions
    
    func add(model: AnyObject, forKey: AnyObject) {
        synchronized(self, block: { self.cachedObjects.setObject(model, forKey: forKey) })
    }
    
    func removeModel(forKey: AnyObject) {
        synchronized(self, block: { self.cachedObjects.removeObject(forKey: forKey) })
    }
    
    func model(forKey: AnyObject) -> AnyObject {
        return synchronized(self, block: { () -> AnyObject in
            return self.cachedObjects.object(forKey: forKey)! })
    }
}
