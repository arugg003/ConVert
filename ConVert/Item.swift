//
//  Item.swift
//  ConVert
//
//  Created by Andres Ruggiero on 8/4/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

import Foundation

class Item {
    var targetName: String = ""
    var targetCurrency: String = ""
    var baseName: String
    var baseCurrency: String
    var exchangeRate: String = ""
    
    init(targetName: String, targetCurrency: String, baseName: String, baseCurrency: String, exchangeRate: String){
        self.baseName = baseName
        self.baseCurrency = baseCurrency
        self.targetName = targetName
        self.targetCurrency = targetCurrency
        self.exchangeRate = exchangeRate
    }
}