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
    
    private func appendCommands() {
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 1234, path: .launch, data: Details(timeout: 0)))
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 12345, path: .pressHomeButton))
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 12346, path: .homeScreenPress))
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 12347, path: .homeScreenEdit))
        commands.append(OutcomingMessage(method: .outcomingMessage, path: .quit))
    }
    
     func handleGETRequest(app: Application) {
         appendCommands()
        app.get("command") { [weak self] req -> OutcomingMessage in
            let defaultCommand = OutcomingMessage(method: .outcomingMessage, id: 1234, path: .launch, data: Details(timeout: 0))
            guard let self = self else { return defaultCommand }
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
