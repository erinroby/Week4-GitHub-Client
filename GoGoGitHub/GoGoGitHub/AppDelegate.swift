//
//  AppDelegate.swift
//  GoGoGitHub
//
//  Created by Erin Roby on 6/27/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        print("AppDelegate - OpenUrl Func URL: \(url)")
        GitHubOAuth.shared.tokenRequestWithCallback(url, options: SaveOptions.userDefaults) { (success) in
            if success  {
                print("We have a token!!!")
            }
        }
        return true
    }
}

