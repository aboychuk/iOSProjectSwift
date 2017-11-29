//
//  LoadingView.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class LoadingView: View {

    //MARK: - Properties
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView?
    
//    var visible: Bool
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public functions

    func set(visible: Bool, animated: Bool, on completion:()->()) {
        
    }
    
    //MARK: - Private functions
    
    func prepareView() {
        self.autoresizingMask = 
        
    }
    
    func prepareActivityIndicator() {
        
    }
}
