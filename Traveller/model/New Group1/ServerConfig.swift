//
//  ServerConfig.swift
//  Traveller
//
//  Created by Tal Sahar on 18/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
public class ServerConfig {
    static let ip = "10.0.0.20"
    static let port = 5555
}

public enum PackageType: String {
    case coordinate = "#COORDINATE"
    case message = "#MSG"
    case outofrange = "#OutOfRange"
    
}
