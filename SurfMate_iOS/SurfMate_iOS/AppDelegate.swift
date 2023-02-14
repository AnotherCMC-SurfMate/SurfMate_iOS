//
//  AppDelegate.swift
//  SurfMate_iOS
//
//  Created by Jun on 2022/11/30.
//

import UIKit
import Firebase
import KakaoSDKAuth
import KakaoSDKCommon
import NaverThirdPartyLogin
import UserNotifications
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        KakaoSDK.initSDK(appKey: "fd4f047eab7ab4e35759cf2d95f6e908")
        
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        
        instance?.isInAppOauthEnable = true
        instance?.isNaverAppOauthEnable = true
        instance?.serviceUrlScheme = "surfmatenaverlogin"
        instance?.consumerKey = "u_Uq19f7ZyJ5pIr_atnY"
        instance?.appName = "SurfMate"
        instance?.consumerSecret = "AVHFbflBYM"
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
            
        }
        
        application.registerForRemoteNotifications()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

