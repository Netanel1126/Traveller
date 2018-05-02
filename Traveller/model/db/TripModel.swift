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
    
    func getTrip(tripId: String) -> Trip?{
        return data.filter {$0.id == tripId}.first
    }
    
    func storeTrip(trip: Trip, onComplete: @escaping (Error?) -> Void){
        let json = trip.toJson()
        let path = FirebaseModel.tripPath + trip.id
        
        FirebaseModel.storeObject(path: path, json: json) { error in
            onComplete(error)
        }
    }
}
