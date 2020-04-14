import UIKit
import CoreData

class AddAdventurerCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var portraitView: UIImageView!
    var portrait_name = "comic"
}
// THIS IS THE VIEW CONTROLLER FOR THE ADD MEMBER VIEW
class AddAdventurerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var ClassField: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let portrait_names = ["comic","bumblebee","frink","guy","lisa","smithers"]
    var chosenPortraitName = "comic"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
        let prtrt = chosenPortraitName
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
        characters.append(adventurer)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        print(3)
      return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "portraitCell", for: indexPath) as! AddAdventurerCollectionViewCell
        cell.backgroundColor = nil
        cell.portraitView?.image = UIImage(named: portrait_names[indexPath.row])
        cell.portrait_name = portrait_names[indexPath.row]
        return cell
    }
                        
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? AddAdventurerCollectionViewCell{
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
            chosenPortraitName = cell.portrait_name
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = nil
        }
    }
}
