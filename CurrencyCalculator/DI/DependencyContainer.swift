//
//  DependencyContainer.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

final class DependencyContainer {
    
    private static var cache: [String: Any] = [:]
    private static var generators: [String: () -> Any] = [:]
    
    static func register<T>(
        type: T.Type,
        as dependencyType: DependencyType = .automatic,
        factory: @autoclosure @escaping () -> T
    ) {
        generators[String(describing: type.self)] = factory
        
        if dependencyType == .singleton {
            cache[String(describing: type.self)] = factory()
        }
    }
    
    static func resolve<T>(
        _ type: T.Type,
        as dependencyType: DependencyType = .automatic
    ) -> T? {
        let key = String(describing: type.self)
        switch dependencyType {
        case .singleton:
            if let cachedService = cache[key] as? T {
                return cachedService
            } else {
                fatalError("\(String(describing: type.self)) is not registeres as singleton")
            }
            
        case .automatic:
            if let cachedService = cache[key] as? T {
                return cachedService
            }
            fallthrough
            
        case .newInstance:
            if let service = generators[key]?() as? T {
                cache[String(describing: type.self)] = service
                return service
            } else {
                return nil
            }
        }
    }
    
    static func invalidateCache() {
        cache = [:]
        generators = [:]
    }
}

extension DependencyContainer {
    static func configureDependencies() {
        register(type: CalculatorRemoteDatasourceProtocol.self, factory: CalculatorRemoteDatasource())
        register(type: SymbolsLocalDatasourceProtocol.self, factory: SymbolsLocalDatasource())
        register(type: CalculatorViewModelProtocol.self, factory: CalculatorViewModel())
    }
}
