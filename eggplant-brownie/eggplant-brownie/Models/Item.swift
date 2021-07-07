//
//  Item.swift
//  eggplant-brownie
//
//  Created by Cleber Reis on 10/05/21.
//

import Foundation

class Item: NSObject, NSCoding {
    
    let name: String
    let calories: Double
    
    init(nome: String, calorias: Double) {
        self.name = nome
        self.calories = calorias
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(calories, forKey: "calories")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        calories = coder.decodeDouble(forKey: "calories")
    }
}
