//
//  UsersModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/17/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class UsersModel: ArrayModel<Any> {
    
    struct Keys {
        static let plistName = "users.plist"
        static let usersCount = 10
    }
    
    //MARK: - Properties
    
    let notifications = [NSNotification.Name.UIApplicationWillTerminate,
                         NSNotification.Name.UIApplicationDidEnterBackground]
    
    var savePath: String?
    
    //MARK: - Initializations and Deinitializations
    
    deinit {
        <#statements#>
    }
    
    override init() {
        <#code#>
    }
    
    //MARK: - Public Functions
    
    func saveModel() {
        
    }
    
    func dumpModel() {
        
    }
    
    //MARK: - Overrided Functions
    
    override func performLoadingInBackground() {
        <#code#>
    }
    
    //MARK: - Private Functions
    
    private func subscribeNotifications() {
        
    }
    
    private func unsubscribeNotifications() {
        
    }
}
