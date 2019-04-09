//
//  ArrayModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

class ArrayModel<Element: Equatable> {
    
    //MARK: - Public properties
    
    var elements: Array<Element> = []
    
    //MARK: - Computed properties
    
    var count: Int {
        return self.elements.count
    }
    
    //MARK: - Public methods
    
    func add(element: Element) {
        self.insert(element: element, index: self.count)
    }
    
    func add(elements: [Element]) {
        elements.forEach { self.add(element: $0) }
    }
    
    func insert(element: Element, index: Int) {
        synchronized(self) {
            if self.count >= index {
                self.elements.insert(element, at: index)
            }
        }
    }
    
    func remove(element: Element) {
        self.index(of: element).map { self.removeElement(at: $0) }
    }
    
    func remove(elements: [Element]) {
        elements.forEach { self.remove(element: $0) }
    }
    
    func removeElement(at index: Int) {
        synchronized(self) {
            if self.count > index {
                self.elements.remove(at: index)
            }
        }
    }
    
    func moveElement(at sourceIndex: Int, to destenationIndex: Int) {
        synchronized(self) {
            self.elements.move(from: sourceIndex, to: destenationIndex)
        }
    }
    
    func index(of element: Element) -> Int? {
        return synchronized(self) {
            self.elements.index(of: element)
        }
    }
    
    //MARK: - Subscript
    
    subscript(index: Int) -> Element? {
        get { return index >= 0 && index < count ? self.elements[index] : nil }
        set { newValue.map { self.elements[index] = $0 }}
    }
}

extension ArrayModel: Sequence {
    
    //MARK: - Sequence protocol
    
    func makeIterator() -> ElementIterator<Element> {
        return ElementIterator(array: self.elements)
    }
    
}

struct ElementIterator<Element>: IteratorProtocol {
    
    //MARK: - Iterator protocol
    
    private let array: Array<Element>
    private var index = 0
    
    init(array: Array<Element>) {
        self.array = array
    }
    
    mutating func next() -> Element? {
        if (index < self.array.endIndex) {
            let element = self.array[index]
            index += 1
            
            return element
        } else {
            return nil
        }
    }
}
