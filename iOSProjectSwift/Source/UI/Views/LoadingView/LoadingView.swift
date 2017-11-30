//
//  LoadingView.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class LoadingView: View {
    
    typealias VoidBLock = () -> ()
    
    private struct Constants {
        static let defaultDuration: Double = 3
        static let visibleAlpha: CGFloat = 1
        static let invisibleAlpha: CGFloat = 0.0
        static let defaultAlpha: CGFloat = 0.5
    }

    //MARK: - Properties
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView? {
        willSet {
            if activityIndicator != newValue {
                activityIndicator?.removeFromSuperview()
            }
        }
        didSet {
            if activityIndicator != oldValue {
                self.addSubview(activityIndicator!)
            }
        }
    }
    
    var visible: Bool = false
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareView()
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public functions
    
    static func add(view: UIView) -> LoadingView {
        return LoadingView(frame: view.bounds)
    }

    func set(visible: Bool, animated: Bool = true, on completionHandler: VoidBLock? = nil) {
        UIView.animate(withDuration: animated ? Constants.defaultDuration : 0,
                       animations: { [weak self] in
                        self?.alpha = visible ? Constants.visibleAlpha : Constants.invisibleAlpha
        }) { [weak self](_) in
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
        if var indicator = self.activityIndicator {
            if indicator != nil {
                self.activityIndicator = indicator
                self.addSubview(self.activityIndicator!)
            } else {
                indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
                indicator.autoresizingMask = .autoresize
                indicator.center = self.center
                indicator.startAnimating()
                self.activityIndicator = indicator
                self.addSubview(self.activityIndicator!)
            }
        }
    }
}
