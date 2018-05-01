//
//  CreateTripViewController.swift
//  Traveller
//
//  Created by admin on 06/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit
import RAMReel
class CreateTripViewController: UIViewController {
    
    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var tripDescTextField: UITextField!
    var guide: TravellerUser?
    var tripMap: [Position]?
    @IBOutlet weak var chosenGuideTitle: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMap"{
            let destVewController = segue.destination as! MapViewController
            destVewController.onCompleteDelegate = { map in
                self.tripMap = map
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func drawMapTapped(_ sender: Any) {
        performSegue(withIdentifier: "toMap", sender: nil)
    }
    
    func isVerified() -> Bool {
        if (tripNameTextField.text?.isEmpty)! {
            showAlert(title: "Enter trip name")
            return false
        } else if (tripDescTextField.text?.isEmpty)! {
            showAlert(title: "Enter trip description")
            return false
        } else if guide == nil {
            showAlert(title: "Add another guide")
            return false
        } else if tripMap == nil {
            showAlert(title: "Draw map")
            return false
        }
        return true
    }
    
    @IBAction func addGuidePopupButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        newViewController.onChooseDelegate = { user in
            self.guide = user
            self.chosenGuideTitle.text = user.firstName + " " + user.lastName
        }
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @IBAction func createTapped(_ sender: Any) {
        if isVerified() {
            let uuid = UUID().uuidString
            let currentUser = DefaultUser.getUser()
            let owners = [currentUser!.id, guide!.id]
            let trip = Trip(id: uuid, owners: owners, name: tripNameTextField.text!, description: tripDescTextField.text!, path: tripMap!)
            TripModel.instance.storeTrip(trip: trip) { error in
                let group = Group(groupId: uuid, groupName: trip.name, guideIdList: owners)
                GroupModel.instance.storeGroup(group: group) { error in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
