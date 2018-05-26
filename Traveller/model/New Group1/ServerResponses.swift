//
//  ServerResponses.swift
//  Traveller
//
//  Created by Tal Sahar on 18/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
protocol ServerResponse{}

public struct OutOfRangeResponse: ServerResponse {
    let uid: String
    
    init(uid: String) {
        self.uid = uid
    }
}

public struct MessageResponse: ServerResponse {
    let uid: String
    let message: String
    
    init(uid: String, message: String) {
        self.uid = uid
        self.message = message
    }
}

public struct CoordinateResponse: ServerResponse {
    let uid: String
    let latitude: Double
    let longitude: Double
    
    init(uid: String, latitude: Double, longitude: Double) {
        self.uid = uid
        self.latitude = latitude
        self.longitude = longitude
    }
}

    class ServerResponseBuilder {
        static func buildResponse(message: String?) -> ServerResponse? {
            guard let message = message else { return nil }
            var splitted = message.components(separatedBy: ",")
            if splitted[0] == PackageType.coordinate.rawValue {
                return CoordinateResponse(uid: splitted[1], latitude: Double(splitted[3])!, longitude: Double(splitted[2])!)
            } else if splitted[0] == PackageType.message.rawValue {
                var msg = ""
                for i in 2..<splitted.count {
                    msg.append(splitted[i])
                }
                return MessageResponse(uid: splitted[1], message: msg)
            }
            else if splitted[0] == PackageType.outofrange.rawValue {
                return OutOfRangeResponse(uid: splitted[1])
            } else {
                Logger.log(message: "Unknown package received: \(message)", event: .e)
                return nil
            }
    }
}
