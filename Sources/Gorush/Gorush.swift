//
//  GorushNotification.swift
//  Gorush
//
//  Created by Simon Kempendorf on 15.01.19.
//

import Foundation
import Vapor

public struct Gorush {
    let client: Client
    let url: URI
    let encoder: ContentEncoder
    
    public init(client: Client, hostname: String, path: String = "/api/push", encoder: ContentEncoder = JSONEncoder()) {
        self.client = client
        let scheme = hostname.hasPrefix("http") ? "" : "https"
        self.url = URI(string: "\(scheme)\(hostname)\(path)")
        self.encoder = encoder
    }

    public func dispatch(_ gorushMessage: GorushMessage, on eventLoop: EventLoop) -> EventLoopFuture<GorushResponse> {
        return client.post(url) { (request: inout ClientRequest) in
            var body = ByteBuffer()
            try self.encoder.encode(gorushMessage, to: &body, headers: &request.headers)
            request.body = body
        }.flatMapThrowing { (response: ClientResponse) in
            return try response.content.decode(GorushResponse.self)
        }
    }

    // MARK: Convenience method
    public func dispatch(_ gorushNotification: GorushNotification, on eventLoop: EventLoop) -> EventLoopFuture<GorushResponse> {
        return dispatch(GorushMessage(notifications: [gorushNotification]), on: eventLoop)
    }
}
