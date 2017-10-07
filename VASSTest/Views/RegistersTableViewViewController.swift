//
//  RegistersTableViewViewController.swift
//  VASSTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit
import CustomTableRowFramework

class RegistersTableViewViewController: BaseViewController {
    
    @IBOutlet weak var tblRegisters: UITableView!
    var registers = [RRegister]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tblRegisters.dataSource = self
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.removeNavigationBar()
        self.customizeNavigationBar()
        
        self.showLocations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    internal func removeNavigationBar() {
        let nav = self.navigationController?.navigationBar
        if let subviews = nav?.subviews {
            for subView in subviews {
                if(subView.tag != 0){
                    subView.removeFromSuperview()
                }
            }
        }
    }
    
    func customizeNavigationBar(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationItem.title = "Tabla de registros"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Verdana", size: 15)!]
    }
    
 
    func showLocations(){
        let registersController = RegistersController()
        self.registers = registersController.getRegisters()
        self.tblRegisters.reloadData()
    }


}



// MARK: UITableViewDataSource
extension RegistersTableViewViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.registers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let bundle = Bundle(for: RegistersDetailTableViewCell.self as AnyClass)
        let cell:RegistersDetailTableViewCell = bundle.loadNibNamed("RegistersDetailTableViewCell", owner: self, options: nil)![0] as! RegistersDetailTableViewCell
        
        let selectedRegister = self.registers[indexPath.row]
        
        cell.configureRow(with:  selectedRegister.id, country: selectedRegister.country, name: selectedRegister.name, abbr: selectedRegister.abbr, area: self.getMilesArea(kmFormat: selectedRegister.area) , largestCity: selectedRegister.largestCity, capital: selectedRegister.capital)
        
        return cell
    }
    
}

extension RegistersTableViewViewController{
    func getMilesArea(kmFormat:String) -> String{
        let newString = kmFormat.replacingOccurrences(of: "SKM", with: "")
        if let kilometers = Double(newString){
            let speedInMPH = kilometers / 1.60934
            return "\(speedInMPH)MI"
        }
      
        return "\(0.0)MI"
    }
}




