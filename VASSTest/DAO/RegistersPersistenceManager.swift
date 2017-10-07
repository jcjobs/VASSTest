//
//  RegistersPersistenceManager.swift
//  VASSTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit
import RealmSwift

class RegistersPersistenceManager:  BaseDAO<RRegister, NSString> {
    
    func getAllRegisters()->[RRegister]{
        return self.getAll().toArray(ofType: (RRegister.self) ) as [RRegister]
    }
    
}
