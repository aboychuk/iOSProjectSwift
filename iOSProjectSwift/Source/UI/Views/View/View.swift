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
    
    var loadingView: LoadingView?
    
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
    
    //MARK: - Public Functions
    
    func prepareLoadingView() {
        
    }
    
    func prepareLoadingViewFromNib() {
        
    }
    
    //Function created for overriding
    func fillWithModel(_ model: Model) {
        
    }
    
}
