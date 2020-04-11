//
//  character.swift
//  group19_assignment6
//
//  Created by William Kwon on 4/11/20.
//  Copyright © 2020 group19. All rights reserved.
//

import Foundation

class character{
    
       private var _name: String = "Unknown"
       private var _profession: String = "Unknown"
       private var _level: Int = 0
       private var _currentHP: Int = 0
       private var _totalHP: Int = 0
       private var _attack: Int = 0
      
       var name: String {
           get{
               return self._name
           }
           set (newName) {
               self._name = newName
           }
       }
       var profession: String {
           get{
               return self._profession
           }
           set (newprofession) {
               self._profession = newprofession
           }
       }
       var level: Int {
           get{
               return self._level
           }
           set (newlevel) {
               self._level = newlevel
           }
       }
       var currentHP: Int {
           get{
               return self._currentHP
           }
           set (newcurrentHP) {
               self._currentHP = newcurrentHP
           }
       }
       var totalHP: Int {
                 get{
                     return self._totalHP
                 }
                 set (newtotalHP) {
                     self._totalHP = newtotalHP
                 }
             }
    var attack: Int {
              get{
                  return self._attack
              }
              set (newattack) {
                  self._attack = newattack
              }
          }
  
    init( name: String, profession: String, level: Int, currentHP: Int, totalHP: Int, attack: Int){
        self.name = name
        self.profession = profession
        self.level = level
        self.currentHP = currentHP
        self.totalHP = totalHP
        self.attack = attack
       
       }
}
