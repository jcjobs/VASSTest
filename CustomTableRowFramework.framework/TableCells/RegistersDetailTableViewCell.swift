//
//   rsDetailTableViewCell.swift
//  VASSTest
//
//  Created by Juan Carlos Pérez on 10/7/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

public class  rsDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAbbr: UILabel!
    @IBOutlet weak var lblArea: UILabel!
    @IBOutlet weak var lblLargestCity: UILabel!
    @IBOutlet weak var lblCapital: UILabel!
    
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    public func configureRow(wirh id: String, country: String, name: String, abbr: String, area: String, largestCity: String, capital: String) {
        
        if id.isEmpty {
            lblId.text = "Sin descripción"
        } else {
            lblId.text = "Id: \(id)"
        }
        
        if country.isEmpty {
            lblCountry.text = "Sin descripción"
        } else {
            lblCountry.text = "Country: \(country)"
        }
        
        if name.isEmpty {
            lblName.text = "Sin descripción"
        } else {
            lblName.text = "Name: \(name)"
        }
        
        if  abbr.isEmpty {
            lblAbbr.text = "Sin descripción"
        } else {
            lblAbbr.text = "abbr: \(abbr)"
        }
        
        if  area.isEmpty {
            lblArea.text = "Sin descripción"
        } else {
            lblArea.text = "Area: \(area)"
        }
        
        if  largestCity.isEmpty {
            lblLargestCity.text = "Sin descripción"
        } else {
            lblLargestCity.text = "L. City: \(largestCity)"
        }
        
        if  capital.isEmpty {
            lblCapital.text = "Sin descripción"
        } else {
            lblCapital.text = "Cap: \(capital)"
        }
        
    }
    
}
