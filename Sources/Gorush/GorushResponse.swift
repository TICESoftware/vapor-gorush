//
//  GorushNotification.swift
//  Gorush
//
//  Created by Simon Kempendorf on 15.01.19.
//

import Foundation
import Vapor

public struct GorushResponse: Content {
    public let counts: Int
    public let success: String
    public let logs: [Log]

    public struct Log: Content {
        public let type: String
        public let platform: String
        public let token: String
        public let message: String
        public let error: String
    }
}
