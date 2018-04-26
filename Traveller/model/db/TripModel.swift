//
//  TripModel.swift
//  Traveller
//
//  Created by admin on 14/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
import Firebase

class TripModel {
    
    static let instance = TripModel()
    var data = [Trip]()
    private init() { obseveDatabase() }
    
    //SHOULD BE CALLED ONCE!
    private func obseveDatabase() {
        let path = FirebaseModel.tripPath
        FirebaseModel.loadAllDataAndObserve(path: path) { jsons in
            jsons.forEach { let newTrip = Trip.init(json: $0)
                self.data = self.data.filter {$0.id != newTrip.id}
                self.data.append(newTrip)
            }
            TravellerNotification.tripNotification.post(data: ())
        }
    }
    
    //YOU SHOULDNT USE
    private func getTrip(tripId: String, onSuccess: @escaping (Trip) -> Void, onFailure: @escaping (Error) -> Void){
        let path = FirebaseModel.tripPath + tripId
        FirebaseModel.loadSingleObject(path: path, onComplete: { json in
            let trip = Trip(json: json)
            onSuccess(trip)
        }, onFailure: { error in
            onFailure(error)
        })
    }
    
    func storeTrip(trip: Trip, onComplete: @escaping (Error?) -> Void){
        let json = trip.toJson()
        let path = FirebaseModel.tripPath + trip.id
        
        FirebaseModel.storeObject(path: path, json: json) { error in
            onComplete(error)
        }
    }
}
