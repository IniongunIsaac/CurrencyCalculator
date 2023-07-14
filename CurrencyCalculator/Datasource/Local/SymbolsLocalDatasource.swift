//
//  SymbolsLocalDatasource.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation
import RealmSwift

struct SymbolsLocalDatasource: SymbolsLocalDatasourceProtocol {
    private let realm = try! Realm()
    
    func saveSymbols(_ symbols: [DBSymbol]) {
        do {
            try realm.write {
                realm.add(symbols, update: .modified)
            }
        } catch {
            _print("unable to save symbols => \(error)")
        }
    }
    
    func getSymbols() -> [DBSymbol] {
        Array(realm.objects(DBSymbol.self))
    }
}
