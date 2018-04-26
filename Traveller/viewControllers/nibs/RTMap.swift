//
//  RTMap.swift
//  Traveller
//
//  Created by Tal Sahar on 21/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RTMap: UIView, CLLocationManagerDelegate {
    var tripId: String? {
        didSet {
            startServer()
        }
    }
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
    
    override func awakeFromNib() {
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
}
    
    func startServer() {
        ServerModel.instance.connectServer()
        let user = DefaultUser.getUser()
        let identityPackage = PacketBuilder.identityPacket(gid: tripId!, uid: (user?.id)!)
        ServerModel.instance.send(message: identityPackage)
        manager.delegate = self
        //   manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}
