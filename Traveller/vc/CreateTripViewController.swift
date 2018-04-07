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
    

    @IBAction func createNewTrip(_ sender: Any) {
        let newTrip = Trip(name: tripNameTextField.text!, description: tripDescTextField.text!)
        Model.instance.saveTripToFirebaseDatabase(trip: newTrip)
        
        let newGroup = Group(GroupName: "Group for \(newTrip.getName())")
        Model.instance.saveGroupToFirebaseDatabase(group: newGroup)
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
