//
//  LoadingView.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    typealias VoidBlock = () -> ()
    
    private struct Constants {
        static let defaultDuration: Double = 3
        static let visibleAlpha: CGFloat = 1
        static let invisibleAlpha: CGFloat = 0.0
        static let defaultAlpha: CGFloat = 0.5
    }

    //MARK: - Properties
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView? {
        didSet {
            guard let indicator = activityIndicator else { return }
            self.addSubview(indicator)
            oldValue?.removeFromSuperview()
        }
    }
    
    var visible: Bool = false
    
    //MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func set(visible: Bool, animated: Bool = true, on completionHandler: VoidBlock? = nil) {
        UIView.animate(withDuration: animated ? Constants.defaultDuration : 0,
                       animations: { [weak self] in
                        self?.alpha = visible ? Constants.visibleAlpha : Constants.invisibleAlpha
        }) { (_) in
            completionHandler?()
        }
        
        self.visible = visible
    }
    
    //MARK: - Private functions
    
    private func prepareView() {
        self.autoresizingMask = .autoresizeWithFixedPosition
        self.backgroundColor = UIColor.init(white: 0, alpha: Constants.defaultAlpha)
        self.prepareActivityIndicator()
    }
    
    private func prepareActivityIndicator() {
        let newIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        newIndicator.autoresizingMask = .autoresize
        newIndicator.center = self.center
        newIndicator.startAnimating()
        self.activityIndicator = newIndicator
    }
}
