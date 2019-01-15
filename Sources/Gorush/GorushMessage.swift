//
//  GorushMessage.swift
//  Gorush
//
//  Created by Simon Kempendorf on 15.01.19.
//

import Foundation
import Vapor

public struct GorushMessage: Encodable {
    let notifications: [GorushNotification]

    public init(notifications: [GorushNotification]) {
        self.notifications = notifications
    }
}
