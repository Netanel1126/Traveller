//
//  MapVC.swift
//  Traveller
//
//  Created by Tal Sahar on 11/03/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapVC: UIViewController , CLLocationManagerDelegate{
    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocaion:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.latitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocaion, span)
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
        
        //location.altitude
        //locaion.speed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
