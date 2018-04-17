//
//  FirebaseUserStorage.swift
//  
//
//  Created by Tal Sahar on 11/04/2018.
//

import Foundation
import FirebaseDatabase

//stores user's additional info
class TravellerUserModel {
    
    static func getUser(userId: String, onSuccess: @escaping (TravellerUser) -> Void, onFailure: @escaping (Error) -> Void){
        let path = FirebaseModel.userPath + userId
        FirebaseModel.loadSingleObject(path: path, onComplete: { json in
            let user = TravellerUser(json: json)
            onSuccess(user)
        }, onFailure: { error in
            onFailure(error)
        })
    }
    
    static func storeUser(travellerUser: TravellerUser, onComplete: @escaping (Error?) -> Void){
        let json = travellerUser.toJson()
        let path = FirebaseModel.userPath + travellerUser.id
        FirebaseModel.storeObject(path: path, json: json) { error in
            onComplete(error)
        }
    }
}
