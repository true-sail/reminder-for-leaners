//
//  ListVC.swift
//  ReminderForLearnersProject
//
//  Created by 家田真帆 on 2019/12/01.
//  Copyright © 2019 家田真帆. All rights reserved.
//

import UIKit
import RealmSwift

class ListVC: UIViewController {

var tasks: [ToLearn] = [] {
    didSet {
        tableView.reloadData()
    }
}

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let realm = try! Realm()
        tasks = realm.objects(ToLearn.self).reversed()
    }
    
    @IBAction func didClickButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toInput", sender: nil)
    }
    

   
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.title
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // セルを選択した時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toInput", sender: tasks[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInput" {
            let inputVC = segue.destination as! InputVC
            
            inputVC.task = sender as! ToLearn?
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            
            let task = tasks[indexPath.row]
            
            try! realm.write {
                realm.delete(task)
            }
            
            tasks.remove(at: indexPath.row)
        }
    }
}
