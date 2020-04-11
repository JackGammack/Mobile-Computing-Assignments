//
//  ViewController.swift
//  group19_assignment6
//
//  Created by Jack Gammack on 4/3/20.
//  Copyright © 2020 group19. All rights reserved.
//

import UIKit
import CoreData

// Global Array to store the CoreData object of each Adventurer
var adventurers: [NSManagedObject] = [];

// Custom TableViewCell for each Adventurer
class AdventurerTableViewCell: UITableViewCell{
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var LevelLabel: UILabel!
    @IBOutlet weak var ClassLabel: UILabel!
    @IBOutlet weak var AttackLabel: UILabel!
    @IBOutlet weak var HPLabel: UILabel!
    @IBOutlet weak var PortraitImage: UIImageView!
}

// Main ViewController for TableView
class AdventurerViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let characters = [character(name: "Cloud", profession : "SOLDIER", level : 0, currentHP: 0 ,  totalHP:0, attack:0 ), character(name: "Tifa", profession : "Bartender", level : 0, currentHP: 0 ,  totalHP:0, attack:0),
                      character(name: "Yuffie", profession : "Thief", level : 0, currentHP: 0 ,  totalHP:0, attack:0)
    ]
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
      title = "Adventurers"
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // Checks for new adventurers every time the TableView is pulled up
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      let managedContext =
        appDelegate.persistentContainer.viewContext
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Adventurer")
      do {
        adventurers = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
    
    // Reloads the data in the TableView every time it is pulled up
    override func viewDidAppear(_ animated: Bool){
        self.tableView.reloadData()
    }
    
    // Number of rows in table is length of Adventurers array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return adventurers.count
    }
    
    // Each cell accesses a different CoreData Object that represents an Advenurer
    // Each adventurer is accessed with adventurer=adventurers[indexPath.row]
    // Properties of the adventurer are accessed by doing property=adventurer.value(forKeyPath: "something")
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AdventurerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AdventurerCell", for: indexPath) as! AdventurerTableViewCell
        let adventurer: NSManagedObject = adventurers[indexPath.row]
      cell.NameLabel?.text = adventurer.value(forKeyPath: "name") as? String
      cell.LevelLabel?.text = String(adventurer.value(forKeyPath: "level") as! Int16)
      cell.ClassLabel?.text = adventurer.value(forKeyPath: "profession") as? String
      //Formats the attack value to 2 decimal places
      cell.AttackLabel?.text = String(format: "%.2f",adventurer.value(forKeyPath: "attack") as! Float)
      cell.HPLabel?.text = String(adventurer.value(forKeyPath: "currentHP") as! Int) + "/" + String(adventurer.value(forKeyPath: "totalHP") as! Int)
      //The portrait value is a String that is the name of the image
      //For example "comic" or "bumblebee"
      cell.PortraitImage?.image = UIImage(named: adventurer.value(forKeyPath: "portrait") as! String)
      return cell
    }
    
    // This is the code for deleting rows from the TableView
    // It deletes the row from the table and the data from the CoreData
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            guard let appDelegate =
              UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(adventurers[indexPath.row])
            do {
                try managedContext.save() // <- remember to put this :)
            }
            catch {
                fatalError()
            }
 
            adventurers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
}
