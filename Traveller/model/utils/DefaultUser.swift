//
//  DefaultUser.swift
//  Traveller
//
//  Created by Tal Sahar on 21/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
class DefaultUser {
    static let defaults = UserDefaults.standard

    static func setUser(user: TravellerUser?) {
        defaults.set(user?.id ?? "", forKey: "id")
        defaults.set(user?.email ?? "", forKey: "email")
        defaults.set(user?.firstName ?? "", forKey: "firstName")
        defaults.set(user?.lastName ?? "", forKey: "lastName")
        defaults.set(user?.phoneNumber ?? "", forKey: "phoneNumber")
        defaults.set(user?.imgUrl ?? "", forKey: "imgUrl")
    }
    
    static func getUser() -> TravellerUser? {
        guard let id = defaults.string(forKey: "id") else {return nil}
        if id == "" {
            return nil
        }
        guard let email = defaults.string(forKey: "email") else {return nil}
        guard let firstName = defaults.string(forKey: "firstName") else {return nil}
        guard let lastName = defaults.string(forKey: "lastName") else {return nil}
        guard let phoneNumber = defaults.string(forKey: "phoneNumber") else {return nil}
        guard let imgUrl = defaults.string(forKey: "imgUrl") else {return nil}
    return TravellerUser(id: id, email: email, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, imgUrl: imgUrl)
    }
}
