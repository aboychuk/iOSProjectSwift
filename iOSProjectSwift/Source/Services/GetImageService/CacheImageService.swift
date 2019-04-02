//
//  CacheImageService.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/21/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift

class CacheImageService {
    
    // MARK: - Properties
    
    static let sharedCache = CacheImageService()
    private var cachedObjects = [URL : WeakHashable<UIImage>]()
    
    //MARK: - Init
    
    private init () { }
    
    //MARK: - Public
    
    func add(model: UIImage, forKey key: URL) {
        synchronized(self) { _ = self.cachedObjects.updateValue(WeakHashable(object: model), forKey: key) }
    }
    
    func removeModel(forKey key: URL) {
        synchronized(self) { _ = self.cachedObjects.removeValue(forKey: key) }
    }
    
    func model(forKey key: URL) -> UIImage? {
        return synchronized(self) { return self.cachedObjects[key]?.object }
    }
    
    
}
