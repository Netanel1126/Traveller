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
    
    static func getTrip(tripCreatorID: String,tripName:String, onSuccess: @escaping (Trip) -> Void, onFailure: @escaping (Error) -> Void){
        let path = FirebaseModel.tripPath + tripCreatorID  + "/" + tripName
        FirebaseModel.loadSingleObject(path: path, onComplete: { json in
            let trip = Trip(fromJson: json)
            onSuccess(trip)
        }, onFailure: { error in
            onFailure(error)
        })
    }
    
    static func storeTrip(tripCreatorID: String,tripName:String,trip: Trip, onComplete: @escaping (Error?) -> Void){
        let json = trip.toJson()
        let path = FirebaseModel.tripPath + tripCreatorID  + "/" + tripName
        
        FirebaseModel.storeObject(path: path, json: json) { error in
            onComplete(error)
        }
    }
    
    static func getAllTrips(tripCreatorID: String){
        let path = FirebaseModel.tripPath + tripCreatorID
        var trips = [Trip]()
        
        FirebaseModel.readAllObjects(path: path) { (data) in
            
            if data != nil{
                for child in data!{
                    if let childData = child as? DataSnapshot{
                        if let json = childData.value as? [String:Any]{
                            let trip = Trip(fromJson: json)
                            trips.append(trip)
                        }
                    }
                }
                TravellerNotification.getAllTripsNotifcation.post(data: trips)
            }
        }
    }
    
    static func removeTrip(tripName:String,tripCreatorID:String){
        let path = FirebaseModel.tripPath + tripCreatorID + "/" + tripName
        FirebaseModel.removeData(path: path)
    }
}
