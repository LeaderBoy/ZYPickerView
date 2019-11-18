//
//  AppDelegate.swift
//  ZYPickerView
//
//  Created by 杨志远 on 2017/12/29.
//  Copyright © 2017年 BaQiWL. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        self.window?.rootViewController = vc
        return true
    }

}

