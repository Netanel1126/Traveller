//
//  TripUsers.swift
//  Traveller
//
//  Created by admin on 21/05/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
import UIKit

class TripUsers{
    let myGroup:Group
    var users = [TravellerUser]()
    var usersImages = [String:UIImage]()
    
    init(groupId:String) {
        myGroup = GroupModel.instance.data.filter{$0.groupId == groupId}.first!
        
        TravellerNotification.travellerUserNotification.observe { (_) in
            self.getUsers()
        }
        self.getUsers()
    }
    
    private func getUsers(){
        self.users = TravellerUserModel.instance.data.filter{self.myGroup.guideIdList.contains($0.id) || self.myGroup.travellerIdList.contains($0.id)}
        
        for user in self.users{
            ImageFirebaseStorage.loadImage(url: user.imgUrl, onComplete: { (img) in
                self.usersImages[user.id] = img
                if(self.usersImages.count == self.users.count){
                    TravellerNotification.tripUsersNotification.post(data: ())
                }
            })
        }
    }
}
