//
//  Trip.swift
//  Traveller
//
//  Created by admin on 06/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation

class Trip {
    
    var id:String
    var owners:[String]
    var name: String
    var description: String
    var path: [Position]
    
    init(id:String,owners:[String], name: String, description: String, path: [Position]) {
        self.id = id
        self.owners = owners
        self.name = name
        self.description = description
        self.path = path
    }
    
    init(json: [String:Any]) {
        id = json["id"] as! String
        owners = FirebaseConverter.decodeToStringArray(str: json["owners"] as! String)
        name = json["name"] as! String
        description = json["description"] as! String
        path = FirebaseConverter.decodeTripPath(str: json["path"] as! String)
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        json["owners"] = owners
        json["name"] = name
        json["description"] = description
        json["path"] = FirebaseConverter.encodeTripPath(path: path) 
        return json
    }
}
