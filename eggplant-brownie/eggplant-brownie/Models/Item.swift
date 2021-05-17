//
//  Item.swift
//  eggplant-brownie
//
//  Created by Cleber Reis on 10/05/21.
//

import Foundation

class Item: NSObject {
    let nome: String
    let calorias: Double
    
    init(nome: String, calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
}
