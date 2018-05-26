//
//  NotificationModel.swift
//  Traveller
//
//  Created by Tal Sahar on 12/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
import UIKit

class ModelNotificationBase<T>{
    var name:String?
    
    init(name:String){
        self.name = name
    }
    
    func observe(callback:@escaping (T?)->Void)->Any{
        return NotificationCenter.default.addObserver(forName: NSNotification.Name(name!), object: nil, queue: nil) { (data) in
            if let data = data.userInfo?["data"] as? T {
                callback(data)
            }
        }
    }
    
    func post(data:T?){
        NotificationCenter.default.post(name: NSNotification.Name(name!), object: self, userInfo: ["data":data])
    }
}

class TravellerNotification {

    static let GetMapNotification = ModelNotificationBase<[Position]>(name: "GetMapNotification") //Map draw
    
    //model notifications
    static let travellerUserNotification = ModelNotificationBase<Void>(name: "travellerUserDBNotification")
    static let tripNotification = ModelNotificationBase<Void>(name: "tripNotification")
    static let groupNotification = ModelNotificationBase<Void>(name: "groupNotification")
    static let tripUsersNotification = ModelNotificationBase<Void>(name: "tripUsersNotification")
    //server
    static let serverOutofrangeNotification = ModelNotificationBase<OutOfRangeResponse>(name: "serverOutofrangeNotification")
    static let serverChatNotification = ModelNotificationBase<MessageResponse>(name: "serverChatNotification")
    static let localChatNotification = ModelNotificationBase<Void>(name: "localChatNotification")
    static let serverCoordinateNotification = ModelNotificationBase<CoordinateResponse>(name: "serverCoordinateNotification")
    static let localCoordinateNotification = ModelNotificationBase<Void>(name: "localCoordinateNotification")
    
    static func removeObserver(observer:Any){
        NotificationCenter.default.removeObserver(observer)
    }
}
