//
//  InlineFunctions.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

protocol Scopable {}

extension Scopable {
    
    @discardableResult @inline(__always) func apply(block: (Self) -> ()) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Scopable {}

extension String: Scopable {}

@discardableResult func with<T>(_ it: T, f:(T) -> ()) -> T {
    f(it)
    return it
}
