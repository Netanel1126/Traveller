//
//  MainUserStorage.swift
//  Traveller
//
//  Created by Tal Sahar on 11/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
import Firebase
class AuthManager {
    
    static func getConnectedUser(onComplete: @escaping (TravellerUser?) -> Void) {
        let firebaseUser = FirebaseUserAuth.getCurrentUser()
        if firebaseUser != nil {
            TravellerUserModel.getUser(userId: (firebaseUser?.uid)!, onSuccess: { travellerUser in
                onComplete(travellerUser)
            }, onFailure: { error in
                Logger.log(message: "Error getting user info from db \(error.localizedDescription)", event: .e)
            })
        } else {
            onComplete(nil)
        }
    }
    
    static func signIn(email: String, password: String, onComplete: @escaping (TravellerUser) -> Void, onFailure: @escaping (Error) -> Void) {
        FirebaseUserAuth.signIn(email: email, password: password, onSuccess: { user in
            let userId = user.uid
            TravellerUserModel.getUser(userId: userId, onSuccess: { newUser in
                Logger.log(message: "Sign in succeed", event: .i)
                onComplete(newUser)
            }, onFailure: { error in
                Logger.log(message: "Error signup to firebase db\(error.localizedDescription)", event: .e)
                onFailure(error)
            })
        }, onFailure: { error in
            Logger.log(message: "Error sign in to firebase auth\(error.localizedDescription)", event: .e)
            onFailure(error)
        })
    }
    
    static func signUp(userStruct: TravellerUser.SignUpStruct, onComplete: @escaping (TravellerUser) -> Void, onFailure: @escaping (Error) -> Void) {
        FirebaseUserAuth.signUp(user: userStruct, onComplete: { user in
            Logger.log(message: "Added new user to FirebaseAuth", event: .i)
            let id = user.uid // set user id as firebase response user id
            let newUser = TravellerUser(id: id, email: userStruct.email, firstName: userStruct.firstName, lastName: userStruct.lastName, phoneNumber: userStruct.phoneNumber, imgUrl: userStruct.imgUrl)
            TravellerUserModel.storeUser(travellerUser: newUser, onComplete: { error in
                if error == nil {
                    onComplete(newUser)
                }
            })
        }, onFailure: { error in
            Logger.log(message: "Error signup to firebase auth \(error.localizedDescription)", event: .e)
            onFailure(error)
        })
    }

    static func logout(didSucceed: @escaping (Bool) -> Void) {
        FirebaseUserAuth.logout() { error in
            if error != nil {
                Logger.log(message: "error in signout \(String(describing: error?.localizedDescription))", event: .e)
                didSucceed(false)
            } else {
                Logger.log(message: "logout succeed", event: .i)
                didSucceed(true)
            }
        }
    }
}
