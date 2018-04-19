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
    var tripPath: [Position]?
    
    convenience init(name: String) {
        self.init(name: name, description: nil, path: nil)
    }
    
    convenience init(name: String, description: String?) {
        self.init(name: name, description: description, path: nil)
    }
    
    init(name: String, description: String?, path: [Position]?) {
        tripName = name
        tripDescription = description
        tripPath = path
    }
    
    init(json: [String:Any]) {
        tripName = json["TripName"] as! String
        tripDescription = json["TripDescription"] as? String
        
        if json["TripPath"] != nil {
            tripPath = json["TripPath"] as? [Position]
        } else {
            tripPath = nil
        }
    }
    
   
    func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["TripName"] = tripName
        json["TripDescription"] = tripDescription
        
        if tripPath != nil {
            json["TripPath"] = tripPath
        }
        
        return json
    }
}
