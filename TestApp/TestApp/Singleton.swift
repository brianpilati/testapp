//
//  Singleton.swift
//  TestApp
//
//  Created by Brian Pilati on 12/30/15.
//  Copyright © 2015 Brian Pilati. All rights reserved.
//

import Foundation

class MySingleton {
    static let mySingleton = MySingleton()
    
    enum defaultsKeys {
        static let keyOne = "firstStringKey"
        static let keyTwo = "secondStringKey"
    }
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var firstName: String = "empty"
    var lastName: String = "empty"
    
    private init() {
        self.loadDefaults()
    }
    
    func setFirstName(firstName: String) -> Void {
        defaults.setValue(firstName, forKey: defaultsKeys.keyOne)
        defaults.synchronize()
    }
    
    func setLastName(lastName: String) -> Void {
        defaults.setValue(lastName, forKey: defaultsKeys.keyTwo)
        defaults.synchronize()
    }
    
    func getFirstName() -> String {
        return firstName
    }
    
    func getLastName() -> String {
        return lastName
    }
    
    func loadDefaults() -> Void {
        firstName = defaults.stringForKey(defaultsKeys.keyOne) != nil ? defaults.stringForKey(defaultsKeys.keyOne)! : "empty 2"
        lastName = defaults.stringForKey(defaultsKeys.keyTwo) != nil ? defaults.stringForKey(defaultsKeys.keyTwo)! : "empty 2"
    }
}
let mySingleton = MySingleton()