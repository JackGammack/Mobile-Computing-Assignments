//
//  Animal.swift
//  group19_assignment5
//
//  Created by Jack Gammack on 3/4/20.
//  Copyright © 2020 group19. All rights reserved.
//

import Foundation

class Animal {
    private var _name: String = "Unknown"
    private var _sciName: String = "Unknown"
    private var _animalClass: String = "Unknown"
    private var _sz: String = "Unknown"
    var name: String {
        get{
            return self._name
        }
        set (newName) {
            self._name = newName
        }
    }
    var sciName: String {
        get{
            return self._sciName
        }
        set (newsciName) {
            self._sciName = newsciName
        }
    }
    var animalClass: String {
        get{
            return self._animalClass
        }
        set (newanimalClass) {
            self._animalClass = newanimalClass
        }
    }
    var sz: String {
        get{
            return self._sz
        }
        set (newsz) {
            self._sz = newsz
        }
    }
    init( name: String, sciName: String, animalClass: String, sz: String){
        self.name = name
        self.sciName = sciName
        self.animalClass = animalClass
        self.sz = sz
    }
}
