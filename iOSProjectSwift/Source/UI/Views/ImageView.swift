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
            if contentImageView != oldValue {
                oldValue?.removeFromSuperview()
                contentImageView.map { self.addSubview($0) }
            }
        }
    }
    
    //MARK: - Private
    
    private func setupUI() {
        let contentImageView = UIImageView(frame: self.bounds)
        contentImageView.autoresizingMask = .autoresize
        self.contentImageView = contentImageView
    }
    
    private func getUrl(from string: String?) {
        _ = string.map { self.url = URL(string: $0) }
    }
    
    private func loadImage() {
        self.setupUI()
        self.contentImageView?.loadImage(fromURL: self.url)
    }
}
