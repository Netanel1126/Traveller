//
//  GuideTabBarController.swift
//  Traveller
//
//  Created by Tal Sahar on 27/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

class GuideTabBarController: UITabBarController {
    
    var tripId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapView = viewControllers![0] as! MapVC
        setNavigationBarStyle()
        guard let tripId = tripId else {Logger.log(message: "no tripid found", event: .e)
            dismiss(animated: true, completion: nil)
            return
        }
        guard let trip = TripModel.instance.getTrip(tripId: tripId) else {
            Logger.log(message: "no trip found by id: \(tripId)", event: .e)
            dismiss(animated: true, completion: nil)
            return
        }
        guard let userid = DefaultUser.getUser()?.id else {Logger.log(message: "no userid on local", event: .e)
            dismiss(animated: true, completion: nil)
            return
        }
        if trip.owners.contains(userid) {
            title = "Guide"
        } else {
            title = "Traveler"
            }
        mapView.trip = trip
    }
}
