//
//  GorushNotification.swift
//  Gorush
//
//  Created by Simon Kempendorf on 15.01.19.
//

import Foundation
import Vapor

public final class Gorush: Service {
    let httpScheme: HTTPScheme
    let hostname: String
    let url: String
    let port: Int?
    let encoder: DataEncoder

    public init(httpScheme: HTTPScheme = .https, hostname: String, port: Int? = nil, url: String = "/api/push", encoder: DataEncoder = JSONEncoder()) {
        self.httpScheme = httpScheme
        self.hostname = hostname
        self.port = port
        self.url = url
        self.encoder = encoder
    }

    public func dispatch(_ gorushMessage: GorushMessage, on worker: Worker) -> Future<GorushResponse> {
        return HTTPClient.connect(scheme: httpScheme, hostname: hostname, port: port, on: worker).flatMap { client in
            let headers = [("Content-Type", "application/json")]
            let body = try self.encoder.encode(gorushMessage)
            let request = HTTPRequest(method: .POST, url: self.url, headers: HTTPHeaders(headers), body: body)

            return client.send(request).map { response in
                return try JSONDecoder().decode(GorushResponse.self, from: response.body.data!)
            }
        }
    }

    // MARK: Convenience method

    public func dispatch(_ gorushNotification: GorushNotification, on worker: Worker) -> Future<GorushResponse> {
        return dispatch(GorushMessage(notifications: [gorushNotification]), on: worker)
    }
}
