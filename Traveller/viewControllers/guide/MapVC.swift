//
//  MapVC.swift
//  Traveller
//
//  Created by admin on 13/03/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit
import Toast_Swift
import CoreLocation
import MapKit
import Toast_Swift

class MapVC: ViewController {
    @IBOutlet var map: MKMapView!
    let locationManager = CLLocationManager()
    var annotationHolder: AnnotationHolder?
    var trip: Trip?
    var isRunning = false
    var myLocation: CLLocationCoordinate2D?
    var algThreadTimer: Timer?
    var isGuide = false
    var coordinateObserver: Any?
    var outOfRangeObserver: Any?
    var user = DefaultUser.getUser()!
    
    
    override func viewDidLoad() {
        guard let trip = trip else { Logger.log(message: "no trip found", event: .e); dismiss(); return}
        
        if !ServerModel.instance.connectServer(gid: trip.id, uid: user.id) { dismiss() }
        
        bindLocation()
        
        if let path = drawMap() {
            annotationHolder = AnnotationHolder(path: path)
        } else {
            Logger.log(message: "Couldnt claculate path", event: .e)
            dismiss()
        }

        //run algorithm if a regular member
        if !trip.owners.contains(user.id) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.algThreadTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.algCheck), userInfo: nil, repeats: true)
            })
        } else {// bind out of range notifications
            outOfRangeObserver = TravellerNotification.serverOutofrangeNotification.observe() { res in
                //todo:: replace with popup
                let client = TravellerUserModel.instance.data.filter{ $0.id == res?.uid}.first
                self.view.makeToast("\(String(describing: client?.firstName)) \(String(describing: client?.lastName)) is out of range ", duration: 1.0, position: .bottom)
            }
        }
        
        coordinateObserver = TravellerNotification.serverCoordinateNotification.observe() {res in
            guard let response = res else {
                Logger.log(message: "Error listenning coordinate response", event: .e)
                return}
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(response.latitude ,response.longitude)
            guard let sender = (TravellerUserModel.instance.data.filter {$0.id == response.uid}.first) else { Logger.log(message: "error getting user data", event: .e); return }
            annotation.title = sender.firstName
            //            annotation.subtitle = ""
            guard let trip = self.trip else {Logger.log(message: "nil pointer exception getting trip object", event: .e);return}
                if trip.owners.contains(sender.id) {
                    if let oldAnnotation = self.annotationHolder?.addMember(type: .guide, uid: sender.id, annotation: annotation) {
                        self.map.removeAnnotation(oldAnnotation)
                    }
                } else {
                    if let oldAnnotation = self.annotationHolder?.addMember(type: .traveler, uid: sender.id, annotation: annotation) {
                        self.map.removeAnnotation(oldAnnotation)
                    }
                }
        
            self.map.addAnnotation(annotation)
        }
    }
    
    @objc func algCheck()
    {
        guard let myLocation = myLocation else { Logger.log(message: "nil pointer exception while getting location", event: .e); return }
        let userPosition = Position(id: 0, x: myLocation.longitude, y: myLocation.latitude)
        guard let annotationHolder = annotationHolder else { Logger.log(message: "nil pointe exception while getting annotation holder", event: .e);return}
        var params = MinimumDistanceCalculator.AlgParams(map: annotationHolder.path, user: userPosition, guideA: nil, guideB: nil)
        let guides = Array(annotationHolder.guiders.values)
        
        if let guideA = guides.first {
            let guideApos = Position(id: 0, x: guideA.coordinate.longitude, y: guideA.coordinate.latitude)
            params.guideA = guideApos
        }
        
        if let guideB = guides.last, guides.last != guides.first {
            let guideBpos = Position(id: 0, x: guideB.coordinate.longitude, y: guideB.coordinate.latitude)
            params.guideB = guideBpos
        }
        
        let result = MinimumDistanceCalculator.isLegalPosition(params: params, maxDistance: 0.002, singleGuideMaxPositions: 10)
        if !result {
            self.view.makeToast("You are out of range", duration: 1.0, position: .bottom)
            _ = ServerModel.instance.send(message: PacketBuilder.outOfRange())
        }
    }
    
    @IBAction func BackToTrip(_ sender: UIBarButtonItem) {
        dismiss()
    }
    
    func dismiss() {
        locationManager.stopUpdatingLocation()
        _ = ServerModel.instance.stopServer()
        dismiss(animated: true, completion: nil)
    }
}

//My location
extension MapVC: CLLocationManagerDelegate {
    
    func bindLocation() {
        locationManager.delegate = self
        //   manager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.05,0.05)
        myLocation = location.coordinate
        if !ServerModel.instance.send(message: PacketBuilder.coordinatePacket(coordinate: myLocation!)) {
            dismiss()
        }
        let region = MKCoordinateRegion(center: myLocation!, span: span)
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
    }
}

//path builder and drawer
extension MapVC: MKMapViewDelegate {
    func drawMap() -> [Position]? {
        map.delegate = self
        guard let path = self.trip?.path else {return nil}
        let points = path.map({CLLocationCoordinate2DMake($0.y, $0.x)})
        let polyline = MKPolyline(coordinates: points, count: points.count)
        map.add(polyline, level: MKOverlayLevel.aboveLabels)
        return path
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

