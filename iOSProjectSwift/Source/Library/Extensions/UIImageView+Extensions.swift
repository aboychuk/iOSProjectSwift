//
//  UIImageView+Extensions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 4/3/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import UIKit

extension UIImageView {
        
    public func loadImage(fromURL url: URL?) {
        guard let imageURL = url else {
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            let cache =  URLCache.shared
            let request = URLRequest(url: imageURL)
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.transition(toImage: image)
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self.transition(toImage: image)
                        }
                    }
                }).resume()
            }
        }
    }
    
    public func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.image = image
        },
                          completion: nil)
    }

}
