//
//  GalleryViewController.swift
//  group19_assignment5
//
//  Created by Cole Jones on 3/9/20.
//  Copyright © 2020 group19. All rights reserved.
//

import UIKit
class AnimalGalleryHeader: UICollectionReusableView
{
    @IBOutlet weak var header: UILabel!
    
}

class AnimalGalleryfooter: UICollectionReusableView
{
    @IBOutlet weak var footer: UILabel!
    
}



class GalleryViewController : UIViewController {
    
    var Index = -1
    var galleryItems = [String]()
    
    var cAnimal:Animal?
    var cGallery: Dictionary<String, String>?
    
    
    override func viewDidLoad() {
        print(cAnimal!.name)
        super.viewDidLoad()
        accessPlist()
        for item in galleryItems{
            print(item)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        switch kind
        {
            case UICollectionView.elementKindSectionHeader:
                if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? AnimalGalleryHeader
                {
                    header.header.text = cAnimal!.name + " pictures"
                    return header
                }
            
            case UICollectionView.elementKindSectionFooter:
                if let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterView", for: indexPath) as? AnimalGalleryfooter
                {
                    footer.footer.text = "End of " + cAnimal!.name + " pictures"
                    return footer
                }
            
            default:
                return UICollectionReusableView()
        }
        
        return UICollectionReusableView()
    }
    
    private func accessPlist() {
        print(cAnimal!)
        let inputFile = Bundle.main.path(forResource: "GalleryItem", ofType: "plist")
        let inputDataArray = NSArray(contentsOfFile: inputFile!)
        for input in inputDataArray as! [Dictionary<String, String>] {
            for (key, value) in input {
                galleryItems.append("\(key): \(value)")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
