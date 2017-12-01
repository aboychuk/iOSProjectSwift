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
        willSet {
            self.observationController = self.imageModel?.controller(for: self)

            newValue?.load()
        }
        didSet {
            if let controller = self.observationController {
            oldValue?.remove(controller: controller)
            }
        }
    }
    
    var contentImageView: UIImageView? {
        willSet { newValue?.addSubview(self) }
        didSet { oldValue?.removeFromSuperview() }
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
    
    func fill(with model: ImageModel?) {
        self.contentImageView?.image = model?.image
    }
    
    //MARK: - Private functions
    
    private func prepareContentImageView() {
        let imageView = UIImageView(frame: self.bounds)
        imageView.autoresizingMask = .autoresize
        self.contentImageView = imageView
    }
}
