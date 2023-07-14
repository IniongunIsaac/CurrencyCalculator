//
//  DBSymbol.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import RealmSwift

class DBSymbol: Object {
    @Persisted(primaryKey: true) var code: String
    @Persisted var name: String
    
    convenience init(code: String, name: String) {
        self.init()
        self.code = code
        self.name = name
    }
}
