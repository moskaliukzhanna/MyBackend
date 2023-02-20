//
//  File.swift
//  
//
//  Created by Zhanna Moskaliuk on 17.02.2023.
//

import Foundation
import Vapor

final class CommandConntroller {
    var commands: [Codable] = []
    var commandsCount = 0
//    var socketsUUIDDict: [ConnectionSource: [String: URL]] = [:]
    
    private func sendCommands() {
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 1234, path: .launch, data: Details(timeout: 0)))
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 1234, path: .pressHomeButton))
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 1234, path: .homeScreenPress))
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 1234, path: .homeScreenEdit))
        
        Task {
            for command in commands {
                try await Task.sleep(nanoseconds: 10000000000)
                executeCommand(message: command)
            }
        }
    }
    
     func handleGETRequest(app: Application) {
        app.get("command") { [weak self] req -> OutcomingMessage in
//            guard let self = self else { return }
//            guard let name = req.parameters.get("name") else {
//                throw Abort(.internalServerError)
//            }
            let command = OutcomingMessage(method: .outcomingMessage, id: 1234, path: .launch, data: Details(timeout: 0))
            return command
//            return name
        }
    }

    
    fileprivate func executeCommand(message: Encodable) {
        commandsCount += 1
        let source: ConnectionSource = message is OutcomingMessage ? .ui_connect : .swizzling_connect
        if message is OutcomingMessage {
//            send(message: message as! OutcomingMessage, for: source)
        } else {
//            send(message: message as! SwizzlingCommand, for: source)
        }
    }
}
