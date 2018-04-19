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
    var annotations = [String: MKPointAnnotation]()
    var observer: Any?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.05,0.05)
        let myLocation = location.coordinate
        ServerModel.instance.send(message: PacketBuilder.coordinatePacket(coordinate: myLocation))
        let region = MKCoordinateRegion(center: myLocation, span: span)
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        observer = TravellerNotification.serverCoordinateNotification.observe() {res in
            guard let response = res else {
                Logger.log(message: "Error listenning coordinate response", event: .e)
                return}
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(response.latitude ,response.longitude)
            annotation.title = "Title"
            annotation.subtitle = "Subtitle"
            if let previewAnnotation = self.annotations[response.uid] {
                self.map.removeAnnotation(previewAnnotation)
            }
            self.annotations[response.uid] = annotation
            self.map.addAnnotation(annotation)
        }
       ServerModel.instance.connectServer()
        let n = Int(arc4random_uniform(44444))
        let identityPackage = PacketBuilder.identityPacket(gid: "1", uid: String(n))
        ServerModel.instance.send(message: identityPackage)
        manager.delegate = self
        //   manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}
