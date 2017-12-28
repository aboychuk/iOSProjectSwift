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
    
    var imageModel: ImageModel? {
        didSet {
            self.observationController = self.imageModel?.controller(for: self)
            self.imageModel?.load()
            
            if let controller = self.observationController {
                oldValue?.remove(controller: controller)
            }
        }
    }
    
    var contentImageView: UIImageView? {
        didSet {
            self.contentImageView?.addSubview(self)
            oldValue?.removeFromSuperview()
        }
    }
    
    var observationController: ObservableObject.ObservationController? {
        didSet {
            self.observationController?[.didUnload] = { [weak self] _, _ in
                self?.loadingView?.set(visible: false)
            }
            
            self.observationController?[.willLoad] = { [weak self] _, _ in
                self?.loadingView?.set(visible: true)
            }
            
            self.observationController?[.didLoad] = { [weak self] _, _ in
                self?.loadingView?.set(visible: false)
                self?.fill(with: self?.imageModel)
            }
            
            self.observationController?[.didUnload] = { [weak self] _, _ in
                self?.loadingView?.set(visible: false)
            }
        }
    }
    
    //MARK: - Public functions
    
    func fill(with model: ImageModel?) {
        self.contentImageView?.image = model?.image
    }
}
