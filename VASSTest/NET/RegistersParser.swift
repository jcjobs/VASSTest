//
//  RegistersParser.swift
//  VASSTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

protocol RegistersParserDelegate{
    func doneRegistersParserWithObject(_ resgisters : [RRegister], resultWS : CResultWS)
}

class RegistersParser: NSObject {
    
    var delegate:RegistersParserDelegate! = nil
    //var elementValue: String?
    var registersArray = [RRegister]()
    var resultWS : CResultWS? = nil
    
    let SESSION_TRANSACTION_SUCCESS = "200"
    let SESSION_TRANSACTION_ERROR = "-90"
    
    func makeParseWithParametters(_ dataResponse : Data) {
        resultWS = CResultWS.init(succes: "S", errorNumber: SESSION_TRANSACTION_SUCCESS, errorDescripcion: "Success")
        
        do {
            
            let json = try JSONSerialization.jsonObject(with: dataResponse, options: []) as! [String: AnyObject]
            
            if let results = json["RestResponse"] as? NSDictionary {
                
                if let listOfresults = results["result"] as?  [[String : AnyObject]]  {
                    
                    for result in listOfresults{
                        
                        let newRegister =  RRegister()
                        if let id = result["id"] as? Int {
                            newRegister.id = "\(id)"
                        }
                        
                        if let country = result["country"] as? String {
                            newRegister.country = country
                        }
                        
                        if let name = result["name"] as? String {
                            newRegister.name = name
                        }
                        
                        if let abbr = result["abbr"] as? String {
                            newRegister.abbr = abbr
                        }
                        
                        if let area = result["area"] as? String {
                            newRegister.area = area
                        }
                        
                        if let largestCity = result["largest_city"] as? String {
                            newRegister.largestCity = largestCity
                        }
                        
                        if let capital = result["capital"] as? String {
                            newRegister.capital = capital
                        }
                        
                        registersArray.append(newRegister)
                    }
                    
                    
                }
                
                
            }
            
            // MARK: -- Códigos de error
            if let errorStatus = json["status"] as? String {
                resultWS?.errorNumber = errorStatus
            }
            if let errorDescription = json["error"] as? String {
                resultWS?.errorDescripcion = errorDescription
            }
            
        } catch let error as NSError {
            print("error trying to convert data to JSON")
            resultWS?.succes = SESSION_TRANSACTION_ERROR
            resultWS?.errorDescripcion = error.localizedDescription
            resultWS?.errorNumber = "\(error.code)"
        }
        
        
        delegate!.doneRegistersParserWithObject(self.registersArray, resultWS : self.resultWS! )
    }
    
}
