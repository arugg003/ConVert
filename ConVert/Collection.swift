//
//  Collection.swift
//  ConVert
//
//  Created by Andres Ruggiero on 8/4/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

import Foundation

class Collection{
    var collectionName: String
    var baseName: String = ""
    var baseCurrency: String = ""
    var items = [Item]()
    
    init(name: String){
        self.collectionName = name
    }
    
    func addItem(object: Item){
        items.append(object)
    }
}