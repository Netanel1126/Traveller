//
//  CoordinateListener.swift
//  Traveller
//
//  Created by Tal Sahar on 18/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
class CoordinateListener {
    
    static let instance = CoordinateListener()
    var map = [String: CoordinateResponse]()
    
    private init(){
        _ = TravellerNotification.serverCoordinateNotification.observe() {res in
            guard let response = res else {
                Logger.log(message: "Error listenning coordinate response", event: .e)
                return}
            self.map[response.uid] = response
            TravellerNotification.localCoordinateNotification.post(data: ())
        }
    }
}
