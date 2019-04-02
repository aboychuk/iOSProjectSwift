//
//  NetworkImageService.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/21/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift

class NetworkImageService: FileSystemImageService {
    
    // MARK: - Properties
    
    private var task: URLSessionDownloadTask? {
        didSet {
            if task != oldValue {
                oldValue?.cancel()
                task?.resume()
            }
        }
    }
    
    // MARK: - Init
    
    override init(url: URL) {
        self.url = url
    }
    
    // MARK: - Public
    
    override func getImage() {
        if self.isSaved {
            super.getImage()
        } else {
            guard let imagePath = self.imagePath else { return }
            let urlSession = URLSession.shared
            self.task = urlSession.downloadTask(with: self.url, completionHandler: { location, response, error in
                guard let currentPath = location?.path else { return }
                do {
                    try FileManager.default.moveItem(atPath: currentPath, toPath: imagePath)
                        super.getImage()
                } catch {
                    print(error)
                }

            })
        }
    }
    
    enum ImageServiceError: Error {
        case noImagePath
        case noUrlPath
    }
}
