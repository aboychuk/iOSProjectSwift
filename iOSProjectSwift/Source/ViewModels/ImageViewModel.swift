//
//  ImageViewModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/18/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift

class ImageViewModel: ViewModelType {
    
    struct Input {
        let loadImage: AnyObserver<Void>
    }
    
    struct Output {
        let imageObservable: Observable<UIImage>
        let isLoadingObservable: Observable<Bool>
    }
    
    // MARK: - Properties
    
    let input: Input
    let output: Output
    private let service: 
    
    // MARK: - Init
    
}
