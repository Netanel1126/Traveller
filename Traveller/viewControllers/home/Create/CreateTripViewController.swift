//
//  CreateTripViewController.swift
//  Traveller
//
//  Created by admin on 06/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit
import RAMReel
import TextFieldEffects
import RxSwift
import RxCocoa

class CreateTripViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet var fieldCollection: [UIView]!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var tripDescription: UITextView!
    var tripMap: [Position]?
    @IBOutlet weak var otherGuideField: UITextField!
    @IBOutlet weak var searchGuideTableView: UITableView!

    var chosenGuide: TravellerUser?
    var shownGuides = BehaviorSubject<[TravellerUser]>(value: [TravellerUser]())

    let bag = DisposeBag()
    let currentUser = DefaultUser.getUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Trip"
        fieldCollection.forEach {view in
            view.layer.cornerRadius = 3
            view.layer.borderColor = UIColor.lightGray.cgColor
            view.layer.borderWidth = 1
        }
        name.setLeftPaddingPoints(5)
        otherGuideField.setLeftPaddingPoints(5)
    
        otherGuideField.rx.text.orEmpty.bind { input in
            if input.count > 0 {
                let result = TravellerUserModel.instance.data.filter{$0.fullname().starts(with: input)}.filter{$0.fullname() != self.currentUser?.fullname()}
                self.shownGuides.onNext(result)
                var chosen: TravellerUser?
                result.forEach({ user in
                    if (user.firstName + " " + user.lastName) == input {
                        chosen = user
                        self.setTableViewVisibility(isHidden: true)
                    }
                })
                self.chosenGuide = chosen
            }
            self.searchGuideTableView.reloadData()
        }.disposed(by: bag)
        
        shownGuides.subscribe(onNext: { (users) in
            self.setTableViewVisibility(isHidden: users.count == 0)
            self.searchGuideTableView.reloadData()
        }).disposed(by: bag)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMap"{
            if let des = segue.destination as? MapViewController {
                des.onCompleteDelegate = {
                    self.tripMap = $0
                }
            }
        }
    }
    
    @IBAction func drawMapTapped(_ sender: Any) {
        performSegue(withIdentifier: "toMap", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return try! shownGuides.value().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = try! shownGuides.value()[indexPath.row].firstName + " " + shownGuides.value()[indexPath.row].lastName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell:UITableViewCell = searchGuideTableView.cellForRow(at: indexPath) else {return}
            self.otherGuideField.text = cell.textLabel?.text
    }
    
    func setTableViewVisibility(isHidden: Bool) {
        if isHidden {
            UIView.animate(withDuration: 0.3) {
                self.searchGuideTableView.alpha = 0
                self.searchGuideTableView.isHidden = true
            }

        } else {
            searchGuideTableView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.searchGuideTableView.alpha = 1
            }
            
        }
    }
 
    func isVerified() -> Bool {
        if (name.text?.isEmpty)! {
            showAlert(title: "Enter trip name")
            return false
        } else if (tripDescription.text?.isEmpty)! {
            showAlert(title: "Enter trip description")
            return false
        } else if chosenGuide == nil {
            showAlert(title: "Add another guide")
            return false
        } else if tripMap == nil {
            showAlert(title: "Draw map")
            return false
        }
        return true
    }
    
    @IBAction func createTripTapped(_ sender: Any) {
        if isVerified() {
            let uuid = UUID().uuidString
            let currentUser = DefaultUser.getUser()
            guard let userId = currentUser?.id else {return}
            guard let chosenGuideId = chosenGuide?.id else {return}
            let owners = [userId, chosenGuideId]
            let trip = Trip(id: uuid, owners: owners, name: name.text!, description: tripDescription.text, path: tripMap!)
            TripModel.instance.storeTrip(trip: trip) { error in
                let group = Group(groupId: uuid, groupName: trip.name, guideIdList: owners)
                GroupModel.instance.storeGroup(group: group) { error in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
