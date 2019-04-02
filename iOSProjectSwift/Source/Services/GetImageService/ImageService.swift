//
//  GetImageService.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/19/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift

class ImageService {
    
    // MARK: - Properties
    
    private let url: URL
    private var image: UIImage?
    private unowned var cache = CacheImageService.sharedCache
    private let service: ImageServiceType

    // MARK: - Init
    
    init(model: ImageModel) {
        self.model = model
    }
    
    // MARK: - Private
    
    private func load() -> Observable<Result<UIImage>> {
        let url = self.model.url
        return Observable.create { observable in
            var imageModel = self.cache.model(forKey: url)
            if imageModel == nil {
//                self.service = url.isFileURL ? FileSystemImageService()
            }
//            if imageModel == nil {
//                let model = url.isFileURL ? FilesystemImageModel(url: url) : InternetImageModel(url: url)
//                self.cache.add(model: model, forKey: url)
//                imageModel = model
//            }
        }

    }
}
