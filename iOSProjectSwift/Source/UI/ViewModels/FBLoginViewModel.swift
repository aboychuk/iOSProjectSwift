//
//  FBLoginViewModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 12/29/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift

class FBLoginViewModel {
    
    //MARK: - Public properties
    
    let subject = PublishSubject<FBCurrentUserModel>()
    
    //MARK: - Private properties
    
    private var user: FBCurrentUserModel
    
    //MARK: - Initializations
    
    init(user: FBCurrentUserModel) {
        self.user = user
    }
    
    //MARK: - Public methods
    
    func authorize() {
        
    }
}
