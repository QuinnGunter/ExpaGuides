//
//  GuideDescriptionVC.swift
//  Expa Guides
//
//  Created by Quintin Gunter on 5/1/17.
//  Copyright © 2017 Quintin Gunter. All rights reserved.
//

import UIKit
import MapKit

class GuideDescriptionVC: UIViewController {
   
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var bookButtonSet: UIButton!
    @IBAction func bookButton(_ sender: UIButton) {
        
    }
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        bookButtonSet.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
}
