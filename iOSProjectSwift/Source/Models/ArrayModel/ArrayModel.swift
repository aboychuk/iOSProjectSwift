//
//  ArrayModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

protocol ArrayModelObserver {
    func arrayModel(_ : ArrayModel<Any>, updateWithChangeModel: ArrayModelChange)
}

class ArrayModel<T>: Model {
    
    //MARK: - Properties
    
    var objects: Array<T> = []
    var count: Int {
        return self.objects.count
    }
    
    //MARK: - Public Functions
    
    func add(object: T) {
        self.insert(object: object, index: self.count)
    }
    
    func add(objects: [T]) {
        objects.forEach { self.add(object: $0) }
    }
    
    func insert(object: T, index: Int) {
        synchronized(self) {
            if self.count >= index {
                self.objects.insert(object, at: index)
                let modelChange: ArrayModelChange = ArrayModelChangeAdd(index: index)
                self.notifyOfStateWith(modelChange: modelChange)
            }
        }
    }
    
    func remove(object: T) {
        self.removeObject(at: self.index(of: object))
    }
    
    func remove(objects: [T]) {
        objects.forEach { self.remove(object: $0) }
    }
    
    func removeObject(at index: Int) {
        synchronized(self) {
            if self.count > index {
                self.objects.remove(at: index)
                let modelChange: ArrayModelChange = ArrayModelChangeRemove(index: index)
                self.notifyOfStateWith(modelChange: modelChange)
            }
        }
    }
    
    func moveObject(at sourceIndex: Int, to destenationIndex: Int) {
        synchronized(self) {
            self.objects.move(from: sourceIndex, to: destenationIndex)
            let modelChange: ArrayModelChange = ArrayModelChangeMove(sourceIndex: sourceIndex,
                                                                     destinationIndex: destenationIndex)
            self.notifyOfStateWith(modelChange: modelChange)
        }
    }
    
    func index(of object: T) -> Int {
        return self.index(of: object)
    }
    
    //MARK: - Private Functions
    
    private func notifyOfStateWith(modelChange: ArrayModelChange) {
        self.notifyOfState(.didChanged, with: modelChange as ArrayModelChange)
    }
    
    //MARK: - ArrayModel Observer
    
    override func selector(for state: ModelState) -> Selector? {
        switch state {
        case .didChanged:
// Argument of '#selector' refers to instance method 'arrayModel(_:updateWithChangeModel:)' that is not exposed to Objective-C
//            return #selector(ArrayModelObserver.arrayModel)
            return Selector(("arrayModel:"))
        default:
            return super.selector(for: state)
        }
    }
}
