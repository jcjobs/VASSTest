//
//  RRegister.swift
//  VASSTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

import RealmSwift

class RRegister: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var country = ""
    @objc dynamic var name = ""
    @objc dynamic var abbr = ""
    @objc dynamic var area = ""
    @objc dynamic var largestCity = ""
    @objc dynamic var capital = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }

}

