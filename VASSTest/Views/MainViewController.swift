//
//  MainViewController.swift
//  VASSTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnGet: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.stopAnimating()
        
        
        btnGet.layer.cornerRadius = 10
        btnGet.layer.borderWidth = 1
        btnGet.layer.borderColor = UIColor.black.cgColor
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.customizeNavigationBar()
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
    
    
    func customizeNavigationBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func getRegisters(_ sender: Any) {
        
        if Reachability.isConnectedToNetwork() == true {
            activityIndicator.startAnimating()
            
            let registersController = RegistersController()
            registersController.delegate = self
            registersController.makeRequestRegisters()
        }
        else{
            self.showAlert("Aviso", message: "No dispone de una conexión a internet estable")
        }
        
    }

}

extension MainViewController : RegistersControllerDelegate{
    
    func doneMakeRequestRegistersWithParametters(result: String, success: Bool) {
        activityIndicator.stopAnimating()
        if(success){
            self.performSegue(withIdentifier: "showTableView", sender: self)
        }else{
            //Mostrar alerta
            self.showAlert("Aviso", message: result)
        }
    }
}
