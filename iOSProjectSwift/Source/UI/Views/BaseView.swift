//
//  BaseView.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    //MARK: - Properties
    
    var loadingView: LoadingView?
    
    //MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareLoadingView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.prepareLoadingView()
    }
    
    //MARK: - Functions for  overriding

    func fill(with model: Model) {

    }
    
    //MARK: - Private Functions
    
    private func prepareLoadingView() {
        let loadingView: LoadingView? = UINib.object(from: LoadingView.self)
        if let newLoadingView = loadingView {
            newLoadingView.frame = self.bounds
            newLoadingView.set(visible: false)
            self.addSubview(newLoadingView)
            self.loadingView = newLoadingView;
        }
    }
}
