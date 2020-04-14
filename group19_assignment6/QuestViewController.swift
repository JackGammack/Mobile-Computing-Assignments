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
    let monsternames = [
        "Thanos",
        "Venom",
        "Ultron"
        
    ]
    struct Monster{
        var name:String
        var atk:Float
        var monsterHP: Int64
    }
    var currMonster: Monster = Monster(name: "Ultron", atk:3, monsterHP: 30)
    var userTimer = Timer()
    var monsterTimer = Timer()
    
    var monstersDefeated = 0;
    

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
        QuestLog.text += "Beginning Quest...\n"
        
        userTimer = Timer.scheduledTimer(timeInterval:1.5, target:self, selector:#selector(userAtk), userInfo:nil,repeats: true)
        monsterTimer = Timer.scheduledTimer(timeInterval: 2, target:self, selector:#selector(monsterAtk), userInfo:nil,repeats: true)
        

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
    
    //MARK: - User Attack
    @objc func userAtk(){
        randomRange = Float.random(in: 1..<8)
        let atkPoints = atk*randomRange
        QuestLog.text += "\(name) attacks for \(Int(atkPoints)) damage\n"
        currMonster.monsterHP -= Int64(atkPoints)
        if currMonster.monsterHP <= 0 {
            QuestLog.text += "\(currMonster.name) is defeated!\n"
            monstersDefeated += 1
            if( monstersDefeated >= 3 ){
               QuestLog.text += "Level up!\n"
               lvl += 1
               LevelLabel?.text = String(lvl)
               monstersDefeated = 0;
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
            currMonster = Monster(
                name: monsternames[Int.random(in: 0 ..< monsternames.count)],
                atk : Float.random(in: 2 ..< 5),
                monsterHP :Int64(Float.random(in: 20 ..< 50)) )
            QuestLog.text += "\(currMonster.name) enemy appears!\n"
        }
    }
      
        
    //MARK: -<onster Attack
    @objc func monsterAtk(){
        let matkPoints = Float.random(in: 5..<15)
        currHP -= matkPoints
        QuestLog.text += "\(currMonster.name) attacks for \(Int(matkPoints)) damage\n"
        if( currHP <= 0 ){
            currHP = 0
            QuestLog.text += "\(name) is defeated!\n"
            userTimer.invalidate()
            monsterTimer.invalidate()
        }
        HPLabel?.text = String(format: "%.0f", currHP) + "/" + String(character!.value(forKeyPath: "totalHP") as! Int)
    }
    
    @IBAction func EndQuestButton(_ sender: Any) {
        userTimer.invalidate()
        monsterTimer.invalidate()
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
    
}
    

    



