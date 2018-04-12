//
//  NotificationModel.swift
//  Traveller
//
//  Created by Tal Sahar on 12/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation

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
//    static let ConnectedUser = ModelNotificationBase<TravellerUser>(name: "ConnectedUserNotificatio")
//    static let NewUserNotification = ModelNotificationBase<String>(name : "NewUserNotification")
//    static let LogInNotification = ModelNotificationBase<String>(name : "LogInNotification")
//    static let LogOutNotification = ModelNotificationBase<Bool>(name : "LogOutNotification")
//    static let AuthenticationNotification = ModelNotificationBase<String>(name: "AuthenticationNotification")
//
    static func removeObserver(observer:Any){
        NotificationCenter.default.removeObserver(observer)
    }
}
