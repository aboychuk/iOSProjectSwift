//
//  View.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class View: UIView {
    
    //MARK: - Properties
    
    var loadingView: LoadingView? {
        willSet { newValue?.addSubview(self) }
        didSet { oldValue?.removeFromSuperview() }
    }
    
    //MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareLoadingView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareLoadingViewFromNib()
    }
    
    //MARK: - Private Functions
    
    private func prepareLoadingView() {
        self.loadingView = LoadingView.add(view: self)
        }
    
    private func prepareLoadingViewFromNib() {
        let loadingView: LoadingView? = UINib.object(from: LoadingView.self)
        if let view = loadingView {
            view.frame = self.bounds
            view.set(visible: true)
        
            self.loadingView = view;
        }
    }    
}
