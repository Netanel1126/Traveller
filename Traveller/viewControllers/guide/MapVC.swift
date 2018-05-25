//
//  MapVC.swift
//  Traveller
//
//  Created by admin on 13/03/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit
import Toast_Swift
class MapVC: ViewController {
    var mapView: RTMap?
    
    override func viewDidLoad() {
        mapView = .fromNib()

        view.loadView(view: mapView!)
        let tabbar = self.tabBarController as! GuideTabBarController
        mapView?.onOutOfRange = {
            self.view.makeToast("out of range", duration: 3.0, position: .bottom)
        }
        mapView?.tripId = tabbar.tripId
    }

    @IBAction func BackToTrip(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
