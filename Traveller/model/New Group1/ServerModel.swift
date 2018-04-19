//
//  ServerModel.swift
//  Traveller
//
//  Created by Tal Sahar on 18/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
class ServerModel {
    
    static let instance = ServerModel()
    var socket: TSocket
    
    private init() {
        socket = TSocket(address: ServerConfig.ip, port: Int32(ServerConfig.port), messageDelegate: {
                message in
            let msgs = message.components(separatedBy: "\n")
            msgs.forEach {message in
                if message.contains("#COORDINATE") || message.contains("#MESSAGE") {
                    guard let response = ServerResponseBuilder.buildResponse(message: message) else { return }
                    if response is CoordinateResponse {
                        TravellerNotification.serverCoordinateNotification.post(data: (response as! CoordinateResponse))
                    } else if response is MessageResponse {
                        TravellerNotification.serverChatNotification.post(data: (response as! MessageResponse))
                    } else {
                        Logger.log(message: "unknown response: \(message)", event: .e)
                    }
                }
            }
        })
    }
    
    func connectServer() {
        socket.connect()
    }
    
    func stopServer() {
        socket.stopServer()
    }
    
    func send(message: String) {
        socket.send(message: message)
    }
    
}
