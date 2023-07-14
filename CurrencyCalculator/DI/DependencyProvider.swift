//
//  DependencyProvider.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

@propertyWrapper
struct Provided<D> {
    
    var dependency: D
    
    init(as dependencyType: DependencyType = .automatic) {
        guard let dependency = DependencyContainer.resolve(D.self, as: dependencyType) else {
            fatalError("No dependency of type \(String(describing: D.self)) registered!")
        }
        
        self.dependency = dependency
    }
    
    var wrappedValue: D {
        get { self.dependency }
        mutating set { dependency = newValue }
    }
}
