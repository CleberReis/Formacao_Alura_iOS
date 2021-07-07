//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Cleber Reis on 10/05/21.
//

import Foundation

class Meal: NSObject, NSCoding {
    
    let name: String
    let happyness: Int
    var itens: [Item] = []
    
    init(nome: String, felicidade: Int, itens: [Item] = []) {
        self.name = nome
        self.happyness = felicidade
        self.itens = itens
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(happyness, forKey: "happyness")
        coder.encode(itens, forKey: "itens")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        happyness = coder.decodeInteger(forKey: "happyness")
        itens = coder.decodeObject(forKey: "itens") as! Array<Item>
    }
    
    func totalDeCalorias() -> Double {
        var total = 0.0
        
        for item in itens {
            total += item.calories
        }
        
        return total
    }
    
    func detail() -> String {
        var message = "Felicidade: \(happyness)"
        
        for item in itens {
            message += ", \(item.name) - calorias: \(item.calories)"
        }
        
        return message
    }
}
