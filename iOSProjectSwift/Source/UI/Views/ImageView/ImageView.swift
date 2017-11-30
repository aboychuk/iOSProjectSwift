//
//  ImageView.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class ImageView: View {
    
    //MARK: - Properties
    
    var imageModel: ImageModel?
    var contentImageView: UIImageView?
    
    //MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareContentImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareContentImageView()
    }
    
    //MARK: - Public functions
    
    func fill(with model: ImageModel) {
        self.contentImageView?.image = model.image
    }
    
    //MARK: - Private functions
    
    private func prepareContentImageView() {
        let imageView = UIImageView(frame: self.bounds)
        imageView.autoresizingMask = .autoresize
        self.contentImageView = imageView
    }
}
