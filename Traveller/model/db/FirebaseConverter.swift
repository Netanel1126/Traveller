//
//  FirebaseConverter.swift
//  Traveller
//
//  Created by Tal Sahar on 13/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
class FirebaseConverter {
    static func encodeStringArray(array: [String]) -> String{
        var str = ""
        array.forEach {str.append($0)}
        return str
    }
    
    static func decodeToStringArray(str: String) -> [String] {
        return str.components(separatedBy: ",")
    }
}
