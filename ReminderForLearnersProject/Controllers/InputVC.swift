//
//  InputVC.swift
//  ReminderForLearnersProject
//
//  Created by 家田真帆 on 2019/12/01.
//  Copyright © 2019 家田真帆. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

class InputVC: UIViewController {
      var task: ToLearn? = nil
    
    @IBOutlet weak var textFieldQ: UITextField!
   
    @IBOutlet weak var textFieldA: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !isNullOrEmpty(text: task?.title) && !isNullOrEmpty(text: task?.body) {
                       textFieldQ.text = task!.title
                       textFieldA.text = task!.body
               }
    }
    
    @IBAction func didClickButton(_ sender: UIButton) {
        
      // タイトルが空かチェック
            if isNullOrEmpty(text: textFieldQ.text) {
                // textFieldがnilまたは空の時
                return // 処理を中断
            }
            
            // 本文が空かチェック
            if isNullOrEmpty(text: textFieldA.text) {
                return // 処理を中断
            }
            
            // タスクがnilなら新しいタスクを作る
            // それ以外ならタスクを更新
            if task == nil {
                createNewTask(title: textFieldQ.text!, body: textFieldA.text!)
            } else {
                updateTask(newTitle: textFieldQ.text!, newBody: textFieldA.text!, task: task!)
            }
            
            // 前の画面に戻る
            navigationController?.popViewController(animated: true)
        
        
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
        
        }
    
        // nilか空か確かめるメソッド
        // nilまたは空の場合true,それ以外はfalseを返す
        func isNullOrEmpty(text: String?) -> Bool {
            if text == nil || text == "" {
                return true
            } else {
                return false
            }
        }
    
    // 新しく学んだことをRealmに保存するメソッド
        func createNewTask(title: String, body: String) {
            
            // Realmに接続
            let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
            // 新規日記作成
            let task = ToLearn() // インスタンス化
            
            task.title = title
            task.body = body
            task.createdAt = Date()
            task.id = getMaxId()
            
            // Realmに書き込む
            try! realm.write {
                realm.add(task)
            }
        }
        
        // 更新するためのメソッド
        func updateTask(newTitle: String, newBody: String, task: ToLearn) {
            
            let realm = try! Realm()
            
            try! realm.write {
                task.title = newTitle
                task.body = newBody
            }
        }
    
        // 最大のidを取得して、返すメソッド
            func getMaxId() -> Int {
                // Realmに接続
                let realm = try! Realm()
                
                // Automatic Increment機能
                let id = (realm.objects(ToLearn.self).max(ofProperty: "id") as Int? ?? 0) + 1
                
                return id
        }
        
    }
    
  


