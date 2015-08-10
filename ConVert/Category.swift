//
//  Category.swift
//  ConVert
//
//  Created by Andres Ruggiero on 8/4/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

import Foundation

class Category {
    
    var categoryName: String
    var collections = [Collection]()
    
    init(name: String){
        self.categoryName = name;
    }
    
    func addCollection(object: Collection){
        self.collections.append(object)
    }
}