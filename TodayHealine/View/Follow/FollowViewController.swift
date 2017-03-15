//
//  FollowViewController.swift
//  TodayHealine
//
//  Created by lieon on 2017/3/7.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import CoreData

class FollowViewController: UIViewController {
    var foodItem: [Food] = [Food]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupUI()
    }

    @IBAction func remind(_ sender: Any) {
        (UIApplication.shared.delegate as? AppDelegate)?.scheduleNotification()
    }
    
    @IBAction func addFoodAction(_ sender: UIButton) {
        let foodItem = Food(context: DataBaseController.getContext())
        foodItem.added = NSDate()
        if sender.tag == 0 {
            foodItem.type = "Fruit"
        } else {
            foodItem.type = "Vegetable"
        }
        DataBaseController.saveContext()
        loadData()
    }
}

extension FollowViewController {
    fileprivate func setupUI() {
        tableView.rowHeight = 60
        tableView.dataSource = self
    }
    
    fileprivate func loadData() {
        let foodRequest: NSFetchRequest<Food> =  Food.fetchRequest()
        let sortDesciptor = NSSortDescriptor(key: "added", ascending: false)
        foodRequest.sortDescriptors = [sortDesciptor]
         guard let items = try? DataBaseController.getContext().fetch(foodRequest) else { return  }
        if !items.isEmpty {
            foodItem = items
        }
        tableView.reloadData()
    }
    
}

extension FollowViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let food = foodItem[indexPath.row]
        cell.textLabel?.text = food.type
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMMM d yyyy, hh:mm"
        cell.detailTextLabel?.text = dateFormat.string(from: food.added as Date? ?? Date())
        
        if food.type == "Fruit" {
            cell.imageView?.image = UIImage(named: "Apple")
        } else {
            cell.imageView?.image = UIImage(named: "Salad")
        }
        
        return cell
    }
    
}
