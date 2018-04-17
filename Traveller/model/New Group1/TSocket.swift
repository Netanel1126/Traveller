//
//  ClientSocket.swift
//  Traveller
//
//  Created by Tal Sahar on 17/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
import SwiftSocket

class TSocket {
    let client: TCPClient
    var isRunning: Bool = false
    var messageDelegate: ((String) -> Void)
    init(address: String, port: Int32, messageDelegate: @escaping (String) -> Void) {
         client = TCPClient(address: address, port: port)
        self.messageDelegate = messageDelegate
    }
    
    func startReading() {
        isRunning = true
        DispatchQueue.global(qos: .userInitiated).async { // 1
            while self.isRunning {
                guard let response = self.client.read(1024*10, timeout: 1000000) else { return }
                let message = String(bytes: response, encoding: .utf8)
                DispatchQueue.main.async { // 2
                    self.messageDelegate(message!)
                }
            }
        }
    }
    
    
    func send(message: String) {
        switch client.send(string: message) {
        case .success:
            Logger.log(message: "Message has been successfully sent", event: .i)
            break
        case .failure(let error):
            Logger.log(message: "Message send failed: \(error.localizedDescription)", event: .e)
            break
        }
    }
    
    func connect() {
        switch client.connect(timeout: 10) {
        case .success:
            print("Connection has been established")
            break
        case .failure(let error):
            print("connection failed \(error.localizedDescription)")
            break
        }
    }
    
}
