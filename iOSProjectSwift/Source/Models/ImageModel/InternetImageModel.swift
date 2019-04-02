//
//  InternetImageModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/9/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class InternetImageModel: FilesystemImageModel {
    
    //MARK: - Properties
    
    var downloadTask: URLSessionDownloadTask? {
        didSet {
            if downloadTask != oldValue {
                oldValue?.cancel()
                downloadTask?.resume()
            }
        }
    }
    
    //MARK: Overrided Functions

    override func loadImage() {
        let urlSession = URLSession.shared
        let cached = FileManager.default.fileExists(atPath: self.imagePath!)
        if cached {
            super.loadImage()
            
            return
        } else {
            self.downloadTask = urlSession.downloadTask(with: self.url, completionHandler: ({ (location, response, error ) in
                do {
                    try FileManager.default.moveItem(atPath: (location?.path)!, toPath: self.imagePath!)
                    super.loadImage()
                } catch let error as NSError {
                    print(error)
                }
            }))
        }
        
    }
}
