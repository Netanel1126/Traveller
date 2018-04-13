//
//  FirebaseUserStorage.swift
//  
//
//  Created by Tal Sahar on 11/04/2018.
//

import Foundation
import FirebaseDatabase

//stores user's additional info
class FirebaseUserStorage {
    
    static func getUser(userId: String, onSuccess: @escaping (TravellerUser) -> Void, onFailure: @escaping (Error) -> Void){
        let ref = Database.database().reference()
        let userRef = ref.child("Users").child(userId)
            userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                if let json = snapshot.value as? [String:Any]{
                    let user = TravellerUser(json: json)
                    onSuccess(user)
                } else {
                    let error = NSError(domain: "error reading userId \(userId) from FirebaseStorage", code: 0, userInfo: nil)
                    onFailure(error)
                }
            })
    }
    
    static func storeUser(user: TravellerUser, onSuccess: @escaping (TravellerUser) -> Void, onFailure: @escaping (Error) -> Void){
        let ref = Database.database().reference()
        let userRef = ref.child("Users").child(user.id)
        let json = user.toJson()
        userRef.setValue(json, withCompletionBlock: { (error, ref) in
            if error == nil {
                onSuccess(user)
            } else {
                onFailure(error!)
            }
        })
    }
}
