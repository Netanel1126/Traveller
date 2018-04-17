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
    var socket: TSocket?
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.05,0.05)
        let myLocation = location.coordinate
        socket?.send(message: PacketBuilder.coordinatePacket(coordinate: myLocation))
        let region = MKCoordinateRegion(center: myLocation, span: span)
        
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        socket = TSocket(address: "10.0.0.30", port: 5555, messageDelegate: {
            message in
            print(message)
        })
        guard let socket = socket else { return }
        socket.connect()
        let n = Int(arc4random_uniform(42))
        let identityPackage = PacketBuilder.identityPacket(gid: "1", uid: String(n))
        socket.send(message: identityPackage)
        socket.startReading()
        sleep(4)
        manager.delegate = self
        //   manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    
    
}
