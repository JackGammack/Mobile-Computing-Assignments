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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        */
    }
    
    // implement stuff for the quest
    
}
