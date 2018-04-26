//
//  GroupModel.swift
//  Traveller
//
//  Created by Tal Sahar on 13/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
import FirebaseDatabase

class GroupModel {
    
    static let instance = GroupModel()
    var data = [Group]()
    
    private init() {obseveDatabase()}
    
    //SHOULD BE CALLED ONCE!
    private func obseveDatabase() {
        let path = FirebaseModel.groupPath
        FirebaseModel.loadAllDataAndObserve(path: path) { jsons in
            jsons.forEach { let newGroup = Group.init(json: $0)
                self.data = self.data.filter {$0.groupId == newGroup.groupId}
                self.data.append(newGroup)
            }
            TravellerNotification.groupNotification.post(data: ())
        }
    }
    
    //YOU SHOULDNT USE
    private func getGroup(groupId: String, onSuccess: @escaping (Group) -> Void, onFailure: @escaping (Error) -> Void){
        let path = FirebaseModel.groupPath + groupId
        FirebaseModel.loadSingleObject(path: path, onComplete: { json in
            let group = Group(json: json)
            onSuccess(group)
        }, onFailure: { error in
            onFailure(error)
        })
    }
    
    func storeGroup(group: Group, onComplete: @escaping (Error?) -> Void){
        let json = group.toJson()
        let path = FirebaseModel.groupPath + group.groupId
        FirebaseModel.storeObject(path: path, json: json) { error in
            onComplete(error)
        }
    }
    
    func addUserToGroup(userId: String, groupId: String, onComplete: @escaping (Error?) -> Void) {
        let group = data.filter {$0.groupId == groupId}.first
        if (group?.travellerIdList.contains(userId))! {
            group?.travellerIdList.append(userId)
        }
        storeGroup(group: group!, onComplete: onComplete)
    }
}
