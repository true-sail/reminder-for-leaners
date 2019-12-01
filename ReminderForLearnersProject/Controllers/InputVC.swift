//
//  InputVC.swift
//  ReminderForLearnersProject
//
//  Created by 家田真帆 on 2019/12/01.
//  Copyright © 2019 家田真帆. All rights reserved.
//

import UIKit
import UserNotifications

class InputVC: UIViewController {
      var diary: Diary? = nil
    
    @IBOutlet weak var textFieldQ: UITextField!
   
    @IBOutlet weak var textFieldA: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !isNullOrEmpty(text: diary?.title) && !isNullOrEmpty(text: diary?.body) {
                       textFieldQ.text = diary!.title
                       textFieldA.text = diary!.body
               }
    }
    
    @IBAction func didClickButton(_ sender: UIButton) {
        
        // タイトルが空かチェック
        if isNullOrEmpty(text: textFieldQ.text) {
            // textFieldがnilまたは空の時
            return // 処理を中断
        }
        
        // 通知の作成
            let notificationContent = UNMutableNotificationContent()
            // 通知のタイトルに画面で入力されたタイトルを設定
            notificationContent.title = textFieldQ.text!
            // 通知の本文に画面で入力された本文を設定
            notificationContent.body = textFieldA.text!
            // 通知音にデフォルト音声を設定
            notificationContent.sound = .default
            
            // 通知時間の作成
            var notificationTime = DateComponents()
            let trigger: UNNotificationTrigger
            let calendar = Calendar.current  // 現在時間を取得
            // 時間の設定
//            notificationTime.hour = calendar.component(.hour, from: datePicker.date)
//            notificationTime.minute = calendar.component(.minute, from: datePicker.date)
             
            // 通知に通知時間を設定
//            let trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
//
//            let request = UNNotificationRequest(identifier: "uuid", content: notificationContent, trigger: trigger)
            
         trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        let request = UNNotificationRequest(identifier: "uuid", content: notificationContent, trigger: trigger)
        
        
            // 通知を登録
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        performSegue(withIdentifier: "toList", sender: nil)
        }
        
    }
    
  


