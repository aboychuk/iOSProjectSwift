//
//  GetImageService.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/18/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift

struct GetImageService {
    
    // MARK: - Properties
    
    let model: ImageModel
    
    // MARK: - Init
    
    init(model: ImageModel) {
        self.model = model
    }
    
    // MARK: - Public
    
    public func load() -> Observable<ImageModel> {
        
    }
    
}
