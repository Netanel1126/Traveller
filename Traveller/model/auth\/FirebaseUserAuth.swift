//
//  FirebaseUserAuth.swift
//  Traveller
//
//  Created by admin on 11/02/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import FirebaseAuth
class FirebaseUserAuth {
    
    static func signIn(email: String, password: String, onSuccess: @escaping (User) -> Void, onFailure: @escaping (Error) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {
            (user, error) in
            if error == nil {
                onSuccess(user!)
            } else {
                onFailure(error!)
            }
        }
    }
    
    static func signUp(user: TravellerUser.SignUpStruct, onComplete: @escaping (User) -> Void, onFailure: @escaping (Error) -> Void) {
        let auth = Auth.auth()
        let email = user.email
        let password = user.password
        auth.createUser(withEmail: email, password: password) {
            (user, error) in
            if error == nil {
                onComplete(user!)
            } else {
                onFailure(error!)
            }
        }
    }
    
    static func logout(onComplete: @escaping (Error?) -> Void) {
        do {
            let auth = Auth.auth()
            try auth.signOut()
            onComplete(nil)
        }
        catch {
            onComplete(error)
        }
    }
    
    static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
}
