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
    
    var imageViewModel: ImageViewModel? {
        didSet {
            _ = imageViewModel?.input.fetchImage
        }
    }
    
    var contentImageView: UIImageView? {
        didSet {
            self.contentImageView?.addSubview(self)
            oldValue?.removeFromSuperview()
        }
    }
    
    //MARK: - Public functions
    
    func fill(with model: ImageModel?) {
        self.contentImageView?.image = model?.image
    }
}
