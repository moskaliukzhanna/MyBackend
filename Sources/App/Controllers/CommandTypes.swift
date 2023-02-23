//
//  File.swift
//  
//
//  Created by Zhanna Moskaliuk on 17.02.2023.
//

import Foundation
import Vapor

enum WatchCommand: String, Codable {
    case initial = "/init"
    case shutdown = "/shutdown"
    case launch = "/launch"
    case quit = "/quit"
    case requestHierarchyElement = "/requestHierarchy/element"
    case requestHierarchyApplication = "/requestHierarchy/application"
    case launchSettings = "/settings/launch"
    case terminate = "/terminate"
    case terminateSettings = "/settings/terminate"
    case activate = "/activate"
    case activateSettings = "/settings/activate"
    case element = "/element"
    case text = "/element/text"
    case textByCoordinate = "/coordinate/text"
    case touch = "/touch/click/element"
    case touchCoordinate = "/touch/click/coorinate"
    case alertTap = "/alert/click"
    case screenshot = "/screenshot"
    case screenshotElement = "/screenshot/element"
    case scrollTableDown = "/table/scroll/element/down"
    case scrollTableUp = "/table/scroll/element/up"
    case scrollTableDownCoordinate = "/table/scroll/coordinate/down"
    case scrollTableUpCoordinate = "/table/scroll/coordinate/up"
    case pressHomeButton = "/press/homebutton"
    case longPressElement = "/element/longPress"
    case longPressCoordinate = "/coordinate/longPress"
    case passcode = "/settings/Passcode/click"
    case turnPasscodeOnOff = "/settings/Passcode/turnOnOff/click"
    case settingsTextInput = "/settings/textInput"
    case homeScreenСomplicationTap = "/homeScreen/complication/tap"
    case homeScreenTap = "/homeScreen/tap"
    case homeScreenPress = "/homeScreen/press"
    case homeScreenEdit = "/homeScreen/edit"
    case homeScreenScrollLeft = "/homeScreen/edit/scroll/left"
    case homeScreenScrollRight = "/homeScreen/edit/scroll/right"
    case showNotificationsCenter = "/homeScreen/showNotificationCenter"
    case hideNotificationsCenter = "/homeScreen/hideNotificationCenter"
    case tapNotification = "/notificationCenter/notifications/tap"
    case scrollToNotificationDown = "/notificationCenter/notifications/scrollDown"
    case scrollToNotificationUp = "/notificationCenter/notifications/scrollUp"
    case scrollToNotificationActionDown = "/notificationCenter/notifications/action/scrollDown"
    case scrollToNotificationActionUp = "/notificationCenter/notifications/action/scrollUp"
    case configureComplicationScrollDown = "/homeScreen/configureComplication/scrollDown"
    case configureComplicationScrollUp = "/homeScreen/configureComplication/scrollUp"
    case cancelComplicationPicking = "/homeScreen/configureComplication/cancel"
    case notificationActionTap = "/notificationCenter/notifications/action/tap"
    case clearAllNotifications = "/notificationCenter/notifications/clearAll"
    case selectPickerItem = "/pickerWheel/select"
}

enum WebSocketMessageType: String, Codable {
    case outcomingMessage = "POST" // server ---> client
    case incomingMessage = "GET" // client ---> server
}

struct OutcomingMessage: Content {
    let method: WebSocketMessageType
    var id: Int? = nil
    var path: String?
    var timeout: Double? = nil
    var data: Details? = nil
    
    var value: AnyCodable? = nil

    var callbackId: String? = nil
    var passthrough: AnyCodable? = nil
    var granted: AnyCodable? = nil
    var options: Set<NotificationOptions>? = nil
    var notificationSettings: NotificationStatus? = nil
    var requestId: String? = nil
    var categories: [NotificationCategory]? = nil
    var notificationRequest: NotificationRequest? = nil
    var notification: Notification? = nil
    var response: NotificationResponse? = nil
    var identifiers: [String]? = nil
    var configuration: Configuration? = nil
    var date: Int? = nil
    var toState: String? = nil
    var fromState: String? = nil
    var errorMessage: String? = nil
    
    
//    var command: WatchCommand {
//        guard let path = path else { return nil }
//        let command = WatchCommand(rawValue: path)
//    }
}

struct Details: Content {
    var element: Element? = nil
    var timeout: Int? = nil
    var using: Identification? = nil
    var coordinates: Coordinates? = nil
    var value: String? = nil
    var direction: String? = nil
    var pressDuration: Double? = nil
    var textInput: String? = nil
    var times: Int? = nil
}

enum Identification: String, Content {
    case id = "id"
    case text = "text"
    case coordinates = "coordinates"
}

struct IdentificationProperties: Content {
    var using: Identification? = nil
    var value: String? = nil
}

struct Coordinates: Codable {
    let x1: Int?
    let y1: Int?
    var x2: Int? = nil
    var y2: Int? = nil
}

struct Element: Codable {
    let value: String?
}

struct SwizzlingCommand: Codable {
    var method: WebSocketMessageType
    var id: Int? = nil
    var path: String
    var timeout: Double? = nil
    var value: AnyCodable? = nil
    
    
    var callbackId: String? = nil
    var passthrough: AnyCodable? = nil
    var granted: AnyCodable? = nil
    var options: Set<NotificationOptions>? = nil
    var notificationSettings: NotificationStatus? = nil
    var requestId: String? = nil
    var categories: [NotificationCategory]? = nil
    var notificationRequest: NotificationRequest? = nil
    var notification: Notification? = nil
    var response: NotificationResponse? = nil
    var identifiers: [String]? = nil
    var configuration: Configuration? = nil
    var date: Int? = nil
    var toState: String? = nil
    var fromState: String? = nil
    var errorMessage: String? = nil
}

struct Configuration: Codable {
    var activityType: String? = nil
    var locationType: String? = nil
    var swimmingLocationType: String? = nil
    var lapLength: LapLength? = nil
}

struct LapLength: Codable {
    let unit: String
    let value: Double
}
struct NotificationStatus: Codable {
    var authorizationStatus: AuthorizationStatus? = nil
}

enum NotificationOptions: String, Codable {
    case alert, sound, badge, provisional
}

enum AuthorizationStatus: String, Codable {
    case notDetermined, denied, authorized, provisional
}

struct NotificationCategory: Hashable, Codable {
    let identifier: String
    let actions: Set<NotificationAction>
}

struct NotificationAction: Hashable, Codable {
    let identifier: String
    let title: String
}

struct NotificationRequest: Codable {
    let identifier: String
    let title: String
    let subtitle: String
    var badge: Int? = nil
    let threadIdentifier: String
    let body: String
    let categoryIdentifier: String
    let triggerTimeInterval: TimeInterval?
}

struct Notification: Codable {
    let identifier: String
    let title: String
    let body: String
    let categoryIdentifier: String
    let deliveryDate: Int?
}

struct NotificationResponse: Codable {
    let actionIdentifier: String
    let notificationIdentifier: String
}
