import UIKit
import CoreData

// THIS IS THE VIEW CONTROLLER FOR THE ADD MEMBER VIEW
class AddAdventurerViewController: UIViewController {
    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var ClassField: UITextField!
    
    //IMPLEMENT THE COLLECTION VIEW
    // NEED TO BE ABLE TO
    @IBOutlet weak var PortraitCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // ADDS MEMBER TO TABLE AND COREDATA WHEN THE SAVE BUTTON IS PRESSED
    // ONLY WORKS IF NAME AND CLASS FIELDS ARE POPULATED
    // NEED TO UPDATE THE prtrt VARIABLE SO THAT IT'S NOT HARD CODED
    @IBAction func addMember(_ sender: UIButton) {
        let nm = NameField.text!
        let pr = ClassField.text!
        let lvl = 1
        let randHP = Int.random(in: 50 ..< 150)
        let crrntHP = randHP
        let ttlHP = randHP
        let randAtk = Float.random(in: 2 ..< 5)
        let atk = randAtk
        //THE PRTRT VALUE IS HARD CODED HERE
        //ONCE THE COLLECTION VIEW IS IMPLEMENTED, THE prtrt VARIABLE NEEDS TO
        //BECOME A STRING BASED ON WHICH IMAGE IN THE COLLECTION VIEW IS SELECTED
        let prtrt = "comic"
        if( nm != "" && pr != "" ){
            self.save(name: nm, profession: pr, level: lvl, currentHP: crrntHP, totalHP: ttlHP, attack: atk, portrait: prtrt)
            NameField.text = ""
            ClassField.text = ""
        }
    }
    
    // HELPER FUNCTION FOR addMember()
    // CHANGES VALUES IN COREDATA USING adventurer.setValue()
    // THIS FUNCTIONS ADDS THE NEW MEMBER TO THE adventurers ARRAY
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
      do {
        try managedContext.save()
        adventurers.append(adventurer)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = nil
        }
    }
}
