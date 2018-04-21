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
    
    // format: {id,x,y:id,x,y:id,x,y}
    static func encodeTripPath(path: [Position]) -> String {
        var str = ""
        path.forEach { position in
            str.append("\(position.id),\(position.x),\(position.y):")
        }
        str.removeLast()
        return str
    }
    
    static func decodeTripPath(str: String) -> [Position] {
        var path = [Position]()
        let strArray: [String] = str.components(separatedBy: ":")
        strArray.forEach {path.append(Position(firebaseString: $0)) }
        return path
    }
}
