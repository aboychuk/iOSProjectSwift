//
//  FBGetServiceProtocol.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/6/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift
import FacebookCore
import FacebookLogin
import FacebookShare

protocol FBGetServiceProtocol {
    
    var model: ArrayModel<User>
    
    func parse(_ json: JSON) -> ArrayModel<User> {
    <#code#>
    }
    associatedtype Model
    
    var model: Model { get set }
    var graphPath: String { get }
    var parameters: [String : String] { get }
    var plistName: String { get }
    var pathToCachedResult: String? { get }
    
    func load() -> Observable<Result<Model>>
    func parse(_ json: JSON) -> Model
}

extension FBGetServiceProtocol {
    
    // MARK: - Properties
    
    var pathToCachedResult: String? {
        return FileManager.documentsPathAppend(folder: self.plistName)
    }
    
    // MARK: - Public
    
    /// Proceeds loading in background schedule
    public func load() -> Observable<Result<Model>> {
        return Observable.create { observable in
            let request = GraphRequest(graphPath: self.graphPath, parameters: self.parameters)
            request.start({ response, result in
                switch result {
                case .success(response: let data):
                    data.dictionaryValue.map {
                        self.saveResult(result: $0)
                        let model = self.parse($0)
                        observable.onNext(Result.success(model))
                    }
                case .failed(let error):
                    observable.onNext(Result.failure(error))
                }
            })
            
            return Disposables.create()
        }.observeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background))
    }
    
    func saveResult(result: JSON) {
        _ = self.pathToCachedResult.map { NSKeyedArchiver.archiveRootObject(result, toFile: $0) }
    }
    
    func loadResult() {
        _ = self.pathToCachedResult.map { NSKeyedUnarchiver.unarchiveObject(withFile: $0) }
    }
}

fileprivate enum FBGetServiceError: Error {
    case noData
}

