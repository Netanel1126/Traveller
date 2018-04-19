//
//  MessageListener.swift
//  Traveller
//
//  Created by Tal Sahar on 18/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
class MessageListener {
    
    static let instance = MessageListener()
    var list = [MessageResponse]()
    
    private init(){
        _ = TravellerNotification.serverChatNotification.observe() {res in
            guard let response = res else {
                Logger.log(message: "Error listenning message response", event: .e)
                return}
            self.list.append(response)
            TravellerNotification.localChatNotification.post(data: ())
        }
    }
}
