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
    case launch = "/ui/launch"
    case quit = "/quit"
    case requestHierarchyElement = "/ui/requestHierarchy/element"
    case requestHierarchyApplication = "/ui/requestHierarchy/application"
    case launchSettings = "/ui/settings/launch"
    case terminate = "/ui/terminate"
    case terminateSettings = "/ui/settings/terminate"
    case activate = "/ui/activate"
    case activateSettings = "/ui/settings/activate"
    case element = "/ui/element"
    case text = "/ui/element/text"
    case textByCoordinate = "/ui/coordinate/text"
    case touch = "/ui/touch/click/element"
    case touchCoordinate = "/ui/touch/click/coorinate"
    case alertTap = "/ui/alert/click"
    case screenshot = "/ui/screenshot"
    case screenshotElement = "/ui/screenshot/element"
    case scrollTableDown = "/ui/table/scroll/element/down"
    case scrollTableUp = "/ui/table/scroll/element/up"
    case scrollTableDownCoordinate = "/ui/table/scroll/coordinate/down"
    case scrollTableUpCoordinate = "/ui/table/scroll/coordinate/up"
    case pressHomeButton = "/ui/press/homebutton"
    case longPressElement = "/ui/element/longPress"
    case longPressCoordinate = "/ui/coordinate/longPress"
    case passcode = "/ui/settings/Passcode/click"
    case turnPasscodeOnOff = "/ui/settings/Passcode/turnOnOff/click"
    case settingsTextInput = "/ui/settings/textInput"
    case homeScreenСomplicationTap = "/ui/homeScreen/complication/tap"
    case homeScreenTap = "/ui/homeScreen/tap"
    case homeScreenPress = "/ui/homeScreen/press"
    case homeScreenEdit = "/ui/homeScreen/edit"
    case homeScreenScrollLeft = "/ui/homeScreen/edit/scroll/left"
    case homeScreenScrollRight = "/ui/homeScreen/edit/scroll/right"
    case showNotificationsCenter = "/ui/homeScreen/showNotificationCenter"
    case hideNotificationsCenter = "/ui/homeScreen/hideNotificationCenter"
    case tapNotification = "/ui/notificationCenter/notifications/tap"
    case scrollToNotificationDown = "/ui/notificationCenter/notifications/scrollDown"
    case scrollToNotificationUp = "/ui/notificationCenter/notifications/scrollUp"
    case scrollToNotificationActionDown = "/ui/notificationCenter/notifications/action/scrollDown"
    case scrollToNotificationActionUp = "/ui/notificationCenter/notifications/action/scrollUp"
    case configureComplicationScrollDown = "/ui/homeScreen/configureComplication/scrollDown"
    case configureComplicationScrollUp = "/ui/homeScreen/configureComplication/scrollUp"
    case cancelComplicationPicking = "/ui/homeScreen/configureComplication/cancel"
    case notificationActionTap = "/ui/notificationCenter/notifications/action/tap"
    case clearAllNotifications = "/ui/notificationCenter/notifications/clearAll"
    case selectPickerItem = "/ui/pickerWheel/select"
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
