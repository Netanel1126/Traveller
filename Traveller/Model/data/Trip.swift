//
//  Trip.swift
//  Traveller
//
//  Created by admin on 06/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation

class Trip {
    
    var tripName: String
    var tripDescription: String?
    var tripPath: [Position]
    
    convenience init(name: String) {
        self.init(name: name, description: nil, path: [])
    }
    
    convenience init(name: String, description: String?) {
        self.init(name: name, description: description, path: [])
    }
    
    init(name: String, description: String?, path: [Position]) {
        tripName = name
        tripDescription = description
        tripPath = path
    }
    
    init(fromJson: [String:Any]) {
        tripName = fromJson["TripName"] as! String
        tripDescription = fromJson["TripDescription"] as? String
        
        tripPath = fromJson["TripPath"] as! [Position]
    }
    
    func getName() -> String {
        return self.tripName
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["TripName"] = tripName
        json["TripDescription"] = tripDescription
        
        var positions = [String:Any]()
        for i in 0...tripPath.count - 1{
            positions[i.description] = tripPath[i].toJson()
        }
            
        json["TripPath"] = positions

        return json
    }
}
