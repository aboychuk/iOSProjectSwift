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
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        self.window = UIWindow.window {
            let viewModel = FBLoginViewModel(credentials: Credentials())
            let vc = UINavigationController(rootViewController: FBLoginViewController.create(with: viewModel))
            $0.rootViewController = vc
            $0.makeKeyAndVisible()
        }
        
        _ = Observable<Int>
            .interval(1, scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { _ in
                    print("Resource count: \(RxSwift.Resources.total)")
            }
        )

        
        return true
    }
}
