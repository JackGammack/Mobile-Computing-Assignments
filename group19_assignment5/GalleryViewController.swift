//
//  GalleryViewController.swift
//  group19_assignment5
//
//  Created by Cole Jones on 3/9/20.
//  Copyright © 2020 group19. All rights reserved.
//


import Foundation
import UIKit

class GalleryHeader: UICollectionReusableView{
    
    @IBOutlet weak var headerLabel: UILabel!
    
}

class GalleryFooter:UICollectionReusableView{
    @IBOutlet weak var footerLabel: UILabel!
    
}

class GalleryViewController : UICollectionViewController {
    
    var animal:Animal?
    var gallery: Dictionary<String, String>?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
            
        let plistGallery = Bundle.main.path(forResource: "GalleryItem", ofType: "plist")
        let galleryNSDict = NSDictionary(contentsOfFile: plistGallery!)
        let galleryDict = galleryNSDict as? Dictionary<String, Dictionary<String, String>>
        
        let currentKey = animal!.name
        gallery = galleryDict![currentKey]
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        switch kind
        {
            case UICollectionView.elementKindSectionHeader:
                if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? GalleryHeader
                {
                    header.headerLabel.text = animal!.name
                    return header
                }
            
            case UICollectionView.elementKindSectionFooter:
                if let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as? GalleryFooter
                {
                    footer.footerLabel.text = "End of " + animal!.name
                    return footer
                }
            
            default:
                return UICollectionReusableView()
        }
        
        return UICollectionReusableView()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gallery!.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        

        let currentKey = animal!.name + "\(indexPath.row+1)"
        
        cell.animaLabel.text = gallery![currentKey]
        cell.animalimage.image = UIImage(named: currentKey)
        return cell
    }
}

