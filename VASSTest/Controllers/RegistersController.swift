//
//  LocationsControllerDelegate.swift
//  VASSTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

@objc protocol RegistersControllerDelegate{
    @objc optional func doneMakeRequestWithParametters(result : String, success : Bool)
    func doneMakeRequestRegistersWithParametters(result : String, success : Bool)
}


class RegistersController: NSObject {

    var delegate:RegistersControllerDelegate? = nil
    let registersPersistenceManager = RegistersPersistenceManager()
    
    
    //Request Users from net------>
    var serviceConnector = ServiceConnector()
    
    fileprivate let WS_PARAMETTER_FUNCTION = "all"
    
    func makeRequestRegisters(){
        
        let params:[String:String] = [:]
        serviceConnector.delegate = self
        serviceConnector.makeConnectionWithParametters(WS_PARAMETTER_FUNCTION, params: params)
    }

    func getRegisters()->[RRegister]{
        return registersPersistenceManager.getAllRegisters()
    }
    
}

extension RegistersController : ServiceConnectorDelegate{
    
    func requestReturnedData(_ responseObjectWS: GenericResponseWS) {
        let data = responseObjectWS.dataResponse
        
        if(data != nil){
            let registersParser : RegistersParser = RegistersParser()
            registersParser.delegate = self
            registersParser.makeParseWithParametters(data!)
        } else {
            DispatchQueue.main.async {
               self.delegate!.doneMakeRequestRegistersWithParametters(result: responseObjectWS.responseDescription, success: false)
            }
        }
    }
}

extension RegistersController : RegistersParserDelegate{
   
    func doneRegistersParserWithObject(_ resgisters: [RRegister], resultWS: CResultWS) {
        
        if(resgisters.count > 0){
            
            for register in resgisters{
                //let properties = ["id" : location.id, "name" : location.name , "address" : location.address, "distance" : location.distance, "lat" : location.lat, "lng" : location.lng] as [String : Any]
                registersPersistenceManager.save(register)
            }
            
            DispatchQueue.main.async {
                self.delegate!.doneMakeRequestRegistersWithParametters(result: resultWS.errorNumber, success: true)
            }
        }
        else{
            DispatchQueue.main.async {
                self.delegate!.doneMakeRequestRegistersWithParametters(result: resultWS.errorDescripcion, success: false)
            }
        }
    }
    
}
