//
//  AnimalsTableViewController.swift
//  group19_assignment5
//
//  Created by Jack Gammack on 3/5/20.
//  Copyright © 2020 group19. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell{
    
    @IBOutlet weak var AnimalImage: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
}

class InfoTableViewCell: UITableViewCell{
    
    @IBOutlet weak var SciNameLabel: UILabel!
    @IBOutlet weak var ClassLabel: UILabel!
    @IBOutlet weak var WeightLabel: UILabel!
}

class AnimalsTableViewController: UITableViewController {
    
    let animals = [
        Animal(name: "Great White Shark", sciName: "Carcharodon carcharias", animalClass: "Chondrichthyes", sz: "680.0 kg"),
        Animal(name: "Common Cuttlefish", sciName: "Sepia officinalis", animalClass: "Cephalopoda", sz: "4.0 kg"),
        Animal(name: "Takhi", sciName: "Equus ferus", animalClass: "Mammalia", sz: "300.0 kg"),
        Animal(name: "Asian Elephant", sciName: "Elephas Maximus", animalClass: "Mammalia", sz: "4000.0 kg"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2*animals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if( indexPath.row % 2 == 0 ){
            let name_cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! NameTableViewCell
            let animal = animals[indexPath.row/2]
            
            name_cell.NameLabel?.text = animal.name
            name_cell.AnimalImage?.image = UIImage(named: animal.name)
            
            return name_cell
        }
        else{
            let info_cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! InfoTableViewCell
            let animal = animals[indexPath.row/2]
        
            info_cell.SciNameLabel?.text = animal.sciName
            info_cell.ClassLabel?.text = animal.animalClass
            info_cell.WeightLabel?.text = animal.sz

            return info_cell
        }
    }

}
