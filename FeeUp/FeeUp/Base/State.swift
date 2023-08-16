//
//  State.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/16/23.
//

import Foundation

protocol StateProtocol {
    func updated(_ handler: (inout Self) -> Void) -> Self
}

extension StateProtocol {
    func updated(_ handler: (inout Self) -> Void) -> Self {
        var result = self
        handler(&result)
        return result
    }

    mutating func update(_ handler: (inout Self) -> Void) {
        var result = self
        handler(&result)
        self = result
    }
}
