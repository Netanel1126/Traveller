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
    
    static let instance = TravellerUserModel()
    var data = [TravellerUser]()
    
    private init() {obseveDatabase()}
    
    //SHOULD BE CALLED ONCE!
    private func obseveDatabase() {
        let path = FirebaseModel.userPath
        FirebaseModel.loadAllDataAndObserve(path: path) { jsons in
            jsons.forEach {self.data.append(TravellerUser.init(json: $0))}
            TravellerNotification.travellerUserNotification.post(data: ())
        }
    }
    
    func getUser(userId: String, onSuccess: @escaping (TravellerUser) -> Void, onFailure: @escaping (Error) -> Void){
        let path = FirebaseModel.userPath + userId
        FirebaseModel.loadSingleObject(path: path, onComplete: { json in
            let user = TravellerUser(json: json)
            onSuccess(user)
        }, onFailure: { error in
            onFailure(error)
        })
    }
    
    func getUser(userId: String) -> TravellerUser? {
        return data.filter{$0.id == userId}.first
    }
    
    func getID(fullname: String) -> String? {
        for user in data {
            if user.fullname() == fullname{
                return user.id
            }
        }
        return nil
    }
    
    
    func storeUser(travellerUser: TravellerUser, onComplete: @escaping (Error?) -> Void){
        let json = travellerUser.toJson()
        let path = FirebaseModel.userPath + travellerUser.id
        FirebaseModel.storeObject(path: path, json: json) { error in
            onComplete(error)
        }
    }
}
