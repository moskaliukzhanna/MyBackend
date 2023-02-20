//
//  File.swift
//  
//
//  Created by Zhanna Moskaliuk on 17.02.2023.
//

import Foundation
import Vapor

final class CommandConntroller {
    var commands: [OutcomingMessage] = []
    var commandsCount = 0
//    var socketsUUIDDict: [ConnectionSource: [String: URL]] = [:]
    
    private func appendCommands() {
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 1234, path: .launch, data: Details(timeout: 0)))
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 1234, path: .pressHomeButton))
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 1234, path: .homeScreenPress))
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 1234, path: .homeScreenEdit))
        
//        Task {
//            for command in commands {
//                try await Task.sleep(nanoseconds: 10000000000)
////                executeCommand(message: command)
//            }
//        }
    }
    
     func handleGETRequest(app: Application) {
         appendCommands()
        app.get("command") { [weak self] req -> OutcomingMessage in
            let defaultCommand = OutcomingMessage(method: .outcomingMessage, id: 1234, path: .launch, data: Details(timeout: 0))
            guard let self = self else { return defaultCommand }
//            guard let name = req.parameters.get("name") else {
//                throw Abort(.internalServerError)
//            }
            
            guard let command = self.commands.first else { return defaultCommand }
            self.commands.removeFirst()
            return command
        }
    }
    
    func handlePOSTRequest(app: Application) {
        app.post("command") { req -> String in
            print("Command response: \(req.content)")
            return ""
        }
    }
}
