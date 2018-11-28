//
//  Observable.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/28/18.
//  Copyright © 2018 Andrew Boychuk. All rights reserved.
//

import Foundation

enum State {
    case didLoad
    case didFailLoading
    case willLoad
    case didUnload
}

protocol Observable {
    associatedtype Value
    var notify: Bool { get set }
    var state: State { get set }
    
    func notify(of state: State)
}

protocol Disposable {
    func add(to disposeBag: DisposeBag)
    func dispose()
}

class DisposeBag {
    var subscriptions: [Disposable] = []
    func clean() {
        self.subscriptions.forEach { $0.dispose() }
        self.subscriptions.removeAll()
    }
}

class Subscription<Value> {
    typealias CallbackType = (Value) -> ()
    
    var callbacks: [State : CallbackType]
    
    init(onDidLoad: @escaping CallbackType,
         onDidFailLoading: CallbackType?,
         onWillLoad: CallbackType?,
         onDidUnload: CallbackType?)
    {
        var callbacks: [State : CallbackType] = [:]
        callbacks[.didLoad] = onDidLoad
        callbacks[.didFailLoading] = onDidFailLoading
        callbacks[.willLoad] = onWillLoad
        callbacks[.didUnload] = onDidUnload
        
        self.callbacks = callbacks
    }
    
    subscript(state: State) -> CallbackType? {
        get { return self.callbacks[state] }
        set { self.callbacks[state] = newValue }
    }
}

extension Subscription: Disposable {
    func add(to disposeBag: DisposeBag) {
        disposeBag.subscriptions.append(self)
    }
    
    func dispose() {
        self.callbacks.removeAll()
    }
}

class ObservableObject<T>: Observable {
    typealias Value = T
    typealias CallbackType = (Value) -> ()
    
    var value: Value
    var notify = true
    var state: State = .didUnload {
        didSet { self.notify(of: state) }
    }
    var subscriptions = [Subscription<Value>]()
    
    init(value: Value) {
        self.value = value
    }
    
    func subscribe(notifyInitialy: Bool = false,
                   onDidLoad: @escaping CallbackType,
                   onDidFailLoading: CallbackType? = nil,
                   onWillLoad: CallbackType? = nil,
                   onDidUnload: CallbackType? = nil) -> Subscription<Value>
    {
        let subscription = Subscription.init(onDidLoad: onDidLoad,
                                             onDidFailLoading: onDidFailLoading,
                                             onWillLoad: onWillLoad,
                                             onDidUnload: onDidUnload)
        self.subscriptions.append(subscription)
        
        if notifyInitialy {
            self.notify(of: self.state)
        }
        
        return subscription
    }
    
    internal func notify(of state: State) {
        synchronized(self) {
            if !self.notify { return }
            let value = self.value
            let subscriptions = self.subscriptions
            
            self.subscriptions = subscriptions.filter { !$0.callbacks.isEmpty }
            
            subscriptions.forEach {
                let callback = $0[state]
                
                callback?(value)
            }
        }
    }
}

