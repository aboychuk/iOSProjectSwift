//
//  AppDelegate.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 10/26/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        self.window = UIWindow.window {
            let user = Credentials()
            let service = FBLoginService(credentials: user)
            let viewModel = FBLoginViewModel(service: service)
            let loginViewController = FBLoginViewController.create(with: viewModel)
            $0.rootViewController = loginViewController
            $0.makeKeyAndVisible()
        }
        
//        _ = Observable<Int>
//            .interval(1, scheduler: MainScheduler.instance)
//            .subscribe(
//                onNext: { _ in
//                    print(“Resource count: \(RxSwift.Resources.total).”)
//            }
//        )

        
        return true
    }
}
