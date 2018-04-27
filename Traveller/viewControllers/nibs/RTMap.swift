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

class RTMap: UIView, CLLocationManagerDelegate, MKMapViewDelegate {
    var tripId: String? {
        didSet {
            trip = TripModel.instance.data.filter{$0.id == tripId}.first
            startServer()
            drawMap()
        }
    }
    @IBOutlet var map: MKMapView!
    let manager = CLLocationManager()
    var annotationHolder: AnnotationHolder?
    var observer: Any?
    var trip: Trip?
    
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
            let senderId = TravellerUserModel.instance.data.filter {$0.id == response.uid}.first
            annotation.title = senderId?.firstName
            //            annotation.subtitle = ""
            var oldAnnotation: MKPointAnnotation?
            if (self.trip?.owners.contains((senderId?.id)!))! {
                
                oldAnnotation = self.annotationHolder?.addMember(type: .guide, uid: (senderId?.id)!, annotation: annotation)
            } else {
                oldAnnotation = self.annotationHolder?.addMember(type: .traveler, uid: (senderId?.id)!, annotation: annotation)
            }
            if oldAnnotation != nil {
                self.map.removeAnnotation(oldAnnotation!)
            }
            self.map.addAnnotation(annotation)
        }
    }
    
    func startServer() {
        let user = DefaultUser.getUser()
        ServerModel.instance.connectServer(gid: tripId!, uid: (user?.id)!)
        manager.delegate = self
        //   manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func drawMap() {
        map.delegate = self
        let path = TripModel.instance.data.filter {$0.id == tripId}.first?.path
        let points = path?.map({CLLocationCoordinate2DMake($0.y, $0.x)})
        let polyline = MKPolyline(coordinates: points!, count: (points?.count)!)
        map.add(polyline, level: MKOverlayLevel.aboveLabels)
        annotationHolder = AnnotationHolder(path: path!)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            // draw the track
            let polyLine = overlay
            let polyLineRenderer = MKPolylineRenderer(overlay: polyLine)
            polyLineRenderer.strokeColor = UIColor.blue
            polyLineRenderer.lineWidth = 2.0
            return polyLineRenderer
    }
}
