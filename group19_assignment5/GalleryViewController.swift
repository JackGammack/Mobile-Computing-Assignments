//
//  GalleryViewController.swift
//  group19_assignment5
//
//  Created by Cole Jones on 3/9/20.
//  Copyright © 2020 group19. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    var Index = -1
    private let reuseIdentifier = "animalCollectionCell"
    var galleryItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accessPlist()
        for item in galleryItems{
            print(item)
        }
    }
    
    private func accessPlist() {
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
