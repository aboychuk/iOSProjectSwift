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
    
    public func load() -> Observable<Result<Model>> {
        return Observable.create { observable in
            let request = GraphRequest(graphPath: self.graphPath, parameters: self.parameters)
            request.start({ response, result in
                switch result {
                case .success(response: let data):
                    guard let json = data.dictionaryValue else {
                        observable.onNext(Result.failure(FBGetServiceError.noData))
                    }
                    self.saveResult(result: json)
                    let model = self.parse(json)
                    observable.onNext(Result.success(model))
                case .failed(let error):
                    observable.onNext(Result.failure(error))
                }
            })
        }
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

