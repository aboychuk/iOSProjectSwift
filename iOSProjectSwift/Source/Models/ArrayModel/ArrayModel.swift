//
//  ArrayModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

protocol ArrayModelObserver {
    func array(model: ArrayModel<Any>, updateWithChangeModel: ArrayModelChange)
}

class ArrayModel<Type>: Model {
    
    //MARK: - Properties
    
    var objects: Array<Type> = []
    var count: Int {
        return self.objects.count
    }
    
    //MARK: - Public Functions
    
    func add(object: Type) {
        self.insert(object: object, index: self.count)
    }
    
    func add(objects: Type) {
        for object in objects as! [Type] {
            self.add(object: object)
        }
    }
    
    func insert(object: Type, index: Int) {
        synchronized(self) {
            if self.count >= index {
                self.objects.insert(object, at: index)
                let modelChange: ArrayModelChange = ArrayModelChangeAdd.init(index: index)
                self.notifyOfStateWith(modelChange: modelChange)
            }
        }
    }
    
    func remove(object: Type) {
        self.removeObjectAt(index: self.index(of: object))
    }
    
    func remove(objects: Type) {
        for object in self.objects {
            self.remove(object: object)
        }
    }
    
    func removeObjectAt(index: Int) {
        synchronized(self) {
            if self.count > index {
                self.objects.remove(at: index)
                let modelChange: ArrayModelChange = ArrayModelChangeRemove.init(index: index)
                self.notifyOfStateWith(modelChange: modelChange)
            }
        }
    }
    
    func moveObjectAt(sourceIndex: Int, to destenationIndex: Int) {
        synchronized(self) {
            self.objects.move(from: sourceIndex, to: destenationIndex)
            let modelChange: ArrayModelChange = ArrayModelChangeMove.init(sourceIndex: sourceIndex,
                                                                          destinationIndex: destenationIndex)
            self.notifyOfStateWith(modelChange: modelChange)
        }
    }
    
    func index(of object: Type) -> Int {
        return synchronized(self, block: {
            return self.objects.index(where: { (object) -> Bool in
                return true
            })!
        })
    }
    
    //MARK: - Private Functions
    
    private func notifyOfStateWith(modelChange: ArrayModelChange) {
        self.notifyOfState(.didChanged, with: modelChange as AnyObject)
    }
    
    //MARK: - ArrayModel Observer
    
    override func selector(for state: ModelState) -> Selector? {
        switch state {
        case .didChanged:
            return Selector(("array:"))
        default:
            return super.selector(for: state)
        }
    }
}
