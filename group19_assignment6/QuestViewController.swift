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
    
    var characterIndex : Int?
       
    var character : NSManagedObject?
    
    var name: String = ""
    var lvl: Int16 = 0
    var atk: Float = 0
    var currHP: Float = 0
    
    var questOver: Bool = false
    var randomRange: Float = 0;
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        name = character!.value(forKeyPath: "name") as! String
        lvl = character!.value(forKeyPath: "level") as! Int16
        atk = character!.value(forKeyPath: "attack") as! Float
        currHP = character!.value(forKeyPath: "currentHP") as! Float
        
        
        NameLabel?.text = character!.value(forKeyPath: "name") as! String
        LevelLabel?.text = String(character!.value(forKeyPath: "level") as! Int16)
        ClassLabel?.text = character!.value(forKeyPath: "profession") as! String
        //Formats the attack value to 2 decimal places
        AttackLabel?.text = String(format: "%.2f",character!.value(forKeyPath: "attack") as! Float)
        HPLabel?.text = String(character!.value(forKeyPath: "currentHP") as! Int) + "/" + String(character!.value(forKeyPath: "totalHP") as! Int)
        //The portrait value is a String that is the name of the image
        //For example "comic" or "bumblebee"
        PortraitImage?.image = UIImage(named: character!.value(forKeyPath: "portrait") as! String)
        
        runQuest()

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
    //MARK: - QuestLog function
    
    func runQuest(){
        var monstersDefeated = 0;
        QuestLog.text += "Beginning Quest...\n"
        while( !questOver || currHP > 0 ){
            var monsterHP = Float.random(in: 20 ..< 50)
            QuestLog.text += "A new enemy appears!\n"
            while( monsterHP > 0 && currHP > 0 ){
                randomRange = Float.random(in: 1..<8)
                let atkPoints = atk*randomRange
                monsterHP -= atkPoints
                QuestLog.text += "\(name) attacks for \(Int(atkPoints)) damage\n"
                if( monsterHP <= 0 ){
                    QuestLog.text += "Enemy is defeated!\n"
                    monstersDefeated += 1
                    print(monstersDefeated)
                    if( monstersDefeated >= 5 ){
                        QuestLog.text += "Level up!\n"
                        lvl += 1
                        LevelLabel?.text = String(lvl)
                        monstersDefeated = 0;
                    }
                    break
                }
                let matkPoints = Float.random(in: 5..<15)
                currHP -= matkPoints
                QuestLog.text += "The monster attacks for \(Int(matkPoints)) damage\n"
                if( currHP <= 0 ){
                    currHP = 0
                    QuestLog.text += "\(name) is defeated!\n"
                    questOver = true
                }
                HPLabel?.text = String(format: "%.0f", currHP) + "/" + String(character!.value(forKeyPath: "totalHP") as! Int)
            }
        }
        character!.setValue(lvl, forKeyPath: "level")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        let managedContext =
          appDelegate.persistentContainer.viewContext
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func EndQuestButton(_ sender: Any) {
        questOver = true
    }
}
    

    



