//
//  MapVC.swift
//  Traveller
//
//  Created by admin on 13/03/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit
class MapVC: UIViewController {
    
    var mapView: RTMap?
    
    override func viewDidLoad() {
        mapView = .fromNib()
        view.loadView(view: mapView!)
        let tabbar = self.tabBarController as! GuideTabBarController
        mapView?.tripId = tabbar.tripId
    }
}
