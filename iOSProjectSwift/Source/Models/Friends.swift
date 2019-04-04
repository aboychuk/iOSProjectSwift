//
//  Users.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/17/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class Friends: ArrayModel<User> {
    
    private enum Constants {
        static let plistName = "users.plist"
        static let usersCount = 10
    }
    
    //MARK: - Properties
    
    let notifications = [UIApplication.willTerminateNotification,
                         UIApplication.didEnterBackgroundNotification]
    
    var savePath: String? {
        return FileManager.documentsPathAppend(folder: Constants.plistName)
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
        _ = self.savePath.map { NSKeyedArchiver.archiveRootObject(self.elements, toFile: $0) }
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
        
//    override func performLoadingInBackground() {
//        var objects: Array<User>?
//        if let savePath = self.savePath {
//            objects = NSKeyedUnarchiver.unarchiveObject(withFile: savePath) as? Array<User>
//            if objects == nil {
//                objects = Array(repeating: User(), count: Constants.usersCount)
//            }
//            
//        }
//        self.perform(notification: false) {
//            objects.map { self.add(elements: $0) }
//        }
//        
//        self.state = .didLoad
//    }
    
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
