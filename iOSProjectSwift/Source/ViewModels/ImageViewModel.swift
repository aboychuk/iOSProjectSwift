//
//  ImageViewModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/19/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ImageViewModel: ViewModelType {
    
    struct Input {
        let fetchImage: AnyObserver<Void>
    }
    
    struct Output {
        let imageDriver: Observable<UIImage>
        let isLoadingDriver: Observable<Bool>
        let errorDriver: Observable<Error>
    }
    
    // MARK: - Properties
    
    let input: Input
    let output: Output
    private var service: ImageService
    private let fetchSubject = PublishSubject<Void>()
    private let imageSubject = PublishSubject<UIImage>()
    private let loadingSubject = PublishSubject<Bool>()
    private let errorSubject = PublishSubject<Error>()
    
    // MARK: - Init
    
    init(service: ImageService) {
        self.service = service
        self.input = Input(fetchImage: self.fetchSubject.asObserver())
        self.output = Output(imageDriver: self.imageSubject.asObservable(),
                             isLoadingDriver: self.loadingSubject.asObservable(),
                             errorDriver: self.errorSubject.asObservable())
    }
    
    private func setup() {
        
    }
}
