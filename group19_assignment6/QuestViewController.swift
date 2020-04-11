import UIKit
import CoreData

class QuestViewController: UIViewController{
    
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var LevelLabel: UILabel!
    @IBOutlet weak var ClassLabel: UILabel!
    @IBOutlet weak var AttackLabel: UILabel!
    @IBOutlet weak var HPLabel: UILabel!
    @IBOutlet weak var PortraitImage: UIImageView!
    
    @IBOutlet weak var QuestLog: UITextView!
    var adventurers: [NSManagedObject] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        //MARK: -Fetching the data

        }
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
  //MARK: - Questlog function
        
       

        
        func save( name: String, profession: String, level: Int, currentHP: Int, totalHP: Int, attack: Float, portrait: String ) {
          
          guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
          }
          let managedContext =
            appDelegate.persistentContainer.viewContext
          let entity = NSEntityDescription.entity(forEntityName: "Adventurer",
                                       in: managedContext)!
          let adventurer = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
          
          adventurer.setValue(name, forKeyPath: "name")
          adventurer.setValue(profession, forKeyPath: "profession")
          adventurer.setValue(level, forKeyPath: "level")
          adventurer.setValue(currentHP, forKeyPath: "currentHP")
          adventurer.setValue(totalHP, forKeyPath: "totalHP")
          adventurer.setValue(attack, forKeyPath: "attack")
          adventurer.setValue(portrait, forKeyPath: "portrait")
           
            
          QuestLog.text += "Beginning Quest"
        
          //  character1.adventurer()
          //  monster.adventurer()
            
          /*
           
         if (monster.currentlHP == 0) {
             QuestLog.text += "Enemy is deafeated!"
             monster.adventure //spawn
             QuestLog.text += "A new enemy appears!"
             monsterdefeated.count = +1 //after defeat n of monster level goes up
             }
        elif (monster.currentlHP != 0)
             
             monster.currentHP = monster.currentHP - (character.attack + random.range)
             QuestLog.text +=  "\(character.name) attacks for \(character.attack) damage..."
        elif (adventurer.currentHP != 0{
             //either attack or waiting
             if wait:
             QuestLog.text += "The monster is waiting..."
             character.currentHP = character.currentHP - monster.attack
             QuestLog.text +=  "The monster  attacks for \(monst.attack) damage..."
        end
        }
        elif (adventurer.currentHP == 0{
             end
             }

             */
            
            
          do {
            try managedContext.save()
            adventurers.append(adventurer)
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
        }
        
        
        
        
        //UNCOMMENT THE NEXT SECTION TO POPULATE THE STATS ON THIS VIEW
        //FIRST, UPDATE THE
            // let adventurer: NSManagedObject = *INSERT HERE*
        //LINE SO THAT THE adventurer VARIABLE COMES FROM THE ADVENTURER THAT WAS CLICKED ON ON THE PREVIOUS VIEW or something idk. Maybe look at save() function is AddAdventurerViewController for more useful functions
        
        /*
        let adventurer: NSManagedObject = *INSERT HERE*
        NameLabel?.text = adventurer.value(forKeyPath: "name") as? String
        LevelLabel?.text = String(adventurer.value(forKeyPath: "level") as! Int16)
        ClassLabel?.text = adventurer.value(forKeyPath: "profession") as? String
        //Formats the attack value to 2 decimal places
        AttackLabel?.text = String(format: "%.2f",adventurer.value(forKeyPath: "attack") as! Float)
        HPLabel?.text = String(adventurer.value(forKeyPath: "currentHP") as! Int) + "/" + String(adventurer.value(forKeyPath: "totalHP") as! Int)
        //The portrait value is a String that is the name of the image
        //For example "comic" or "bumblebee"
        PortraitImage?.image = UIImage(named: adventurer.value(forKeyPath: "portrait") as! String)
        
         */}
    // implement stuff for the quest
    
}
    



