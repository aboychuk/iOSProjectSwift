//
//  LoadingView.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class LoadingView: BaseView {
    
    typealias VoidBlock = () -> ()
    
    private struct Constants {
        static let defaultDuration: Double = 3
        static let visibleAlpha: CGFloat = 1
        static let invisibleAlpha: CGFloat = 0.0
        static let defaultAlpha: CGFloat = 0.5
    }

    //MARK: - Properties
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView? {
        willSet { newValue?.addSubview(self) }
        didSet { oldValue?.removeFromSuperview() }
    }
    
    var visible: Bool = false
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.prepareView()
    }
    
    //MARK: - Public functions
    
    static func add(view: UIView) -> LoadingView {
        return LoadingView(frame: view.bounds)
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
        if var indicator: UIActivityIndicatorView? = self.activityIndicator {
            if indicator != nil {
                self.activityIndicator = indicator
            } else {
                indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
                indicator?.autoresizingMask = .autoresize
                indicator?.center = self.center
                indicator?.startAnimating()
                self.activityIndicator = indicator
            }
        }
    }
}
