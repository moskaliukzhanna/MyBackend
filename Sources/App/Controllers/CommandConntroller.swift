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
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 1234, path: WatchCommand.launch.rawValue, data: Details(timeout: 0)))
//        commands.append(OutcomingMessage(method: .outcomingMessage, id: 12345, path: WatchCommand.pressHomeButton.rawValue))
//        commands.append(OutcomingMessage(method: .outcomingMessage, id: 12346, path: WatchCommand.homeScreenPress.rawValue))
//        commands.append(OutcomingMessage(method: .outcomingMessage, id: 12347, path: WatchCommand.homeScreenEdit.rawValue))
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 12348, path: "/swizzle/userNotificationCenter.requestAuthorization.setState", passthrough: AnyCodable(value: true)))
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 12349, path:  "/swizzle/userNotificationCenter.requestAuthorization.call", options: [.alert, .badge, .sound]))
        commands.append(OutcomingMessage(method: .outcomingMessage, id: 123410, path: WatchCommand.alertTap.rawValue, timeout: 5.0, data: Details(using: .text, value: "Don’t Allow")))
//        commands.append(OutcomingMessage(method: .outcomingMessage, path: nil, timeout: 30.0))
//        commands.append(NoCommand)
//        commands.append(OutcomingMessage(method: .outcomingMessage, path: WatchCommand.quit.rawValue))
    }
    
     func handleGETRequest(app: Application) {
         appendCommands()
         app.get("command") { [weak self] req -> OutcomingMessage in
             let defaultCommand = OutcomingMessage(method: .outcomingMessage, path: WatchCommand.quit.rawValue, timeout: 60.0)
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
