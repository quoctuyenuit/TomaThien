//
//  Extension.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/29/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation


// MARK: -- Bool
extension Bool {
    var not: Bool {
        return !self
    }
}

extension Encodable {
    func toData() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}

protocol SafeAccessFileProtocol: class {
    var lockEvent: NSRecursiveLock { get }
}

extension SafeAccessFileProtocol {
    internal func excuteActionInSafe<T>(_ block: @escaping () -> T) -> T {
        lockEvent.lock()
        defer {
            lockEvent.unlock()
        }
        return block()
    }
}

extension Swift.Decodable {
    static func toValue(from data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(self, from: data)
    }
}
