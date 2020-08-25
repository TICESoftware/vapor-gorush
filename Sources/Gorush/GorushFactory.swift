//
//  GorushFactory.swift
//  Gorush
//
//  Created by Simon Kempendorf on 25.08.20.
//

import Foundation
import Vapor

public struct GorushFactory {
    var make: ((Request) -> Gorush)?
    public mutating func use(_ make: @escaping ((Request) -> Gorush)) {
        self.make = make
    }
}

extension Application {
    private struct GorushKey: StorageKey {
        typealias Value = GorushFactory
    }

    public var gorush: GorushFactory {
        get {
            self.storage[GorushKey.self] ?? .init()
        }
        set {
            self.storage[GorushKey.self] = newValue
        }
    }
}

extension Request {
    public var gorush: Gorush {
        self.application.gorush.make!(self)
    }
}
