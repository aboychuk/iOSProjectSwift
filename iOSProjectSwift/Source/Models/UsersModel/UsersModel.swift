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
    
    var savePath: String? {
        var documentsPath = FileManager.documentsPath()
        documentsPath?.append(Keys.plistName)
    }
    
    //MARK: - Initializations and Deinitializations
    
    deinit {

    }
    
    override init() {
        super.init()
        
    }
    
    //MARK: - Public Functions
    
    func saveModel() {
        if let savePath = self.savePath {
            NSKeyedArchiver.archiveRootObject(self.objects, toFile: savePath)
    }
    
    func dumpModel() {
        if let savePath = self.savePath {
            do {
                try FileManager.default.removeItem(atPath: savePath)
            } catch _ {
                print("Remove of usersPlist failed")
            }
        }
    }
    
    //MARK: - Overrided Functions
        
    
    //MARK: - Private Functions
    
//    private func subscribeNotifications() {
//
//    }
//
//    private func unsubscribeNotifications() {
//
//    }
}
