//
//  PacketBuilder.swift
//  Traveller
//
//  Created by Tal Sahar on 17/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
import CoreLocation

class PacketBuilder {
    static func coordinatePacket(coordinate: CLLocationCoordinate2D) -> String {
        return "#COORDINATE,\(coordinate.longitude),\(coordinate.latitude)\n"
    }
    
    static func identityPacket(gid: String, uid: String) -> String {
        return "\(gid),\(uid)\n"
    }
}
