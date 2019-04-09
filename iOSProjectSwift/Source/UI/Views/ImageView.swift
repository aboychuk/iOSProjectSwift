//
//  ImageView.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class ImageView: BaseView {
    
    //MARK: - Properties
    
    var url: URL? {
        didSet {
            self.loadImage()
        }
    }
    
    var urlString: String? {
        didSet {
            self.getUrl(from: urlString)
        }
    }

    var contentImageView: UIImageView? {
        didSet {
            self.contentImageView?.addSubview(self)
            oldValue?.removeFromSuperview()
        }
    }
    
    //MARK: - Private
    
    private func getUrl(from string: String?) {
        _ = string.map { self.url = URL(string: $0) }
    }
    
    private func loadImage() {
        self.contentImageView?.loadImage(fromURL: self.url)
    }
}
