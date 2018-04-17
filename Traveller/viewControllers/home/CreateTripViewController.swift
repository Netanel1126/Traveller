//
//  CreateTripViewController.swift
//  Traveller
//
//  Created by admin on 06/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

class CreateTripViewController: UIViewController {
    
    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var tripDescTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMap"{
            
            let destVewController = segue.destination as! MapViewController
            
            destVewController.tripName = tripNameTextField.text
            destVewController.tripDesc = tripDescTextField.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
