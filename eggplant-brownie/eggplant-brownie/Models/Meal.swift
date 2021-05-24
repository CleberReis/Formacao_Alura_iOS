//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Cleber Reis on 10/05/21.
//

import Foundation

class Meal: NSObject {
    let nome: String
    let feliciadade: Int
    var itens: [Item] = []
    
    init(nome: String, felicidade: Int, itens: [Item] = []) {
        self.nome = nome
        self.feliciadade = felicidade
        self.itens = itens
    }
    
    func totalDeCalorias() -> Double {
        var total = 0.0
        
        for item in itens {
            total += item.calorias
        }
        
        return total
    }
    
    func detail() -> String {
        var message = "Felicidade: \(feliciadade)"
        
        for item in itens {
            message += ", \(item.nome) - calorias: \(item.calorias)"
        }
        
        return message
    }
}
