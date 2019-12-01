//
//  ToRemember.swift
//  ReminderForLearnersProject
//
//  Created by 家田真帆 on 2019/12/01.
//  Copyright © 2019 家田真帆. All rights reserved.
//

import Foundation
import RealmSwift

// 設計図
// Realmに保存するために、「Object」というのを継承(拡張)する
class ToLearn: Object {
    // データを管理するテーブルの作成
    
    // 各タスクのID
    @objc dynamic var id: Int = 0
    // タスクのタイトル
    @objc dynamic var title: String = ""
    // タスクの内容
    @objc dynamic var body: String = ""
    // タスクの作成日
    @objc dynamic var createdAt: Date = Date()
}
