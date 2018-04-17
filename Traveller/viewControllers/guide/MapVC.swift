//
//  MapVC.swift
//  Traveller
//
//  Created by admin on 13/03/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var map: MKMapView!
    let manager = CLLocationManager()

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.05,0.05)
        let myLocation = location.coordinate
        let region = MKCoordinateRegion(center: myLocation, span: span)
        
        map.setRegion(region, animated: true)
         map.showsUserLocation = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
     //   manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

}
