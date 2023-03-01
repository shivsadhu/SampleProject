//
//  SecondViewController.swift
//  Continents
//
//  Created by Shivani Ramanathan on 1/6/23.
//

import UIKit

class SecondViewController: UIViewController {
    var finalDescription: String?
    var countyrArray : Country?
    @IBOutlet var descriptionLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = "Capital : \(countyrArray!.details.capital) \n Currency : \(countyrArray!.details.currency)"
        
    }
}
