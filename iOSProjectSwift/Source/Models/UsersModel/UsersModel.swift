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
        return documentsPath
    }
    
    //MARK: - Initializations and Deinitializations
    
    deinit {
        self.unsubscribeNotifications()
    }
    
    override init() {
        super.init()
        self.subscribeNotifications()
    }
    
    //MARK: - Public Functions
    
    func saveModel() {
        if let savePath = self.savePath {
            NSKeyedArchiver.archiveRootObject(self.objects, toFile: savePath)
        }
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
        
    override func performLoadingInBackground() {
        var objects: Array<AnyObject>?
        if let savePath = self.savePath {
            objects = NSKeyedUnarchiver.unarchiveObject(withFile: savePath) as? Array<AnyObject>
            if objects == nil {
                //factory array
            }
        }
        self.perform(notification: false, block: {
            self.add(objects: objects as Any)
        })
        self.state = .didLoad
    }
    
    //MARK: - Private Functions
    
    private func subscribeNotifications() {
        for notification in self.notifications {
            NotificationCenter.default.addObserver(forName: notification, object: nil, queue: OperationQueue.main, using: { (_) in
                self.saveModel()
            })
        }
    }

    private func unsubscribeNotifications() {
        for notification in self.notifications {
            NotificationCenter.default.removeObserver(self, name: notification, object: nil)
        }
    }
}
