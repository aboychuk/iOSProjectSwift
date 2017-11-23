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
    
    private init () {
        
    }
    
    //MARK: - Public Functions
    
    func add(model: AnyObject, for key: AnyObject) {
        synchronized(self, block: { self.cachedObjects.setObject(model, forKey: key) })
    }
    
    func removeModel(for key: AnyObject) {
        synchronized(self, block: { self.cachedObjects.removeObject(forKey: key) })
    }
    
    func model(for key: AnyObject) -> AnyObject {
        return synchronized(self, block: { () -> AnyObject in
            return self.cachedObjects.object(forKey: key)! })
    }
}
