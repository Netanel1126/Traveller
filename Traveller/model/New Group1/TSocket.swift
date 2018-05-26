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
        DispatchQueue.global(qos: .userInitiated).async {
            while self.isRunning {
                guard let response = self.client.read(1024*10, timeout: 1000000) else { return }
                let message = String(bytes: response, encoding: .utf8)
                DispatchQueue.main.async {
                    self.messageDelegate(message!)
                }
                if message == PacketBuilder.closeAck() {
                    self.isRunning = false
                    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3) {
                        self.client.close()
                    }
                }
            }
        }
    }
    
    func stopServer() -> Error? {
        if isRunning {
            return send(message: PacketBuilder.closeReq())
        }
        Logger.log(message: "Trying to stop unrunning server", event: .e)
        return nil
    }
    
    func send(message: String) -> Error? {
        switch client.send(string: message) {
        case .failure(let error):
            Logger.log(message: "package send failed: \(error.localizedDescription)", event: .e)
            return error
        default: return nil
        }
    }
    
    func connect() -> Error? {
        if !isRunning {
            switch client.connect(timeout: 10) {
            case .success:
                Logger.log(message: "connection with sever has been established", event: .i)
                isRunning = true
                startReading()
            case .failure(let error):
                Logger.log(message: "connection with sever has been failed: \(error.localizedDescription)", event: .e)
                return error
            }
        }
        return nil
    }
}
