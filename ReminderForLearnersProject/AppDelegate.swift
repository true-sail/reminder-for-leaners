//
//  AppDelegate.swift
//  ReminderForLearnersProject
//
//  Created by 家田真帆 on 2019/12/01.
//  Copyright © 2019 家田真帆. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         // 追加
              IQKeyboardManager.shared.enable = true
              
              // 通知の許可を確認するアラートを出す
              let notificationCenter = UNUserNotificationCenter.current()
              
              // 許可のアラートを表示する
              notificationCenter.requestAuthorization(options: [.badge, .sound, .alert]) { (granted, error) in
                  // granted：許可された場合：true, 許可されなかった場合：false
                  
                  if error != nil {
                      // errorがnilでない場合（エラーが発生した場合）
                      return // 処理を中断
                  }
                  
                  if granted {
                      // 許可された場合
                      print("許可された")
                      let center = UNUserNotificationCenter.current()
                      center.delegate = self
                      
                  } else {
                      // 許可されなかった場合
                      print("許可されなかった")
                  }
        }
                  
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

