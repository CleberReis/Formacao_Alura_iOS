//
//  RemoveMealController.swift
//  eggplant-brownie
//
//  Created by Cleber Reis on 06/07/21.
//

import UIKit

class RemoveMealController {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func showMeal(_ meal: Meal, handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: meal.name, message: meal.detail(), preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(btnOK)
        
        let btnRemove = UIAlertAction(title: "Remover", style: .destructive, handler: handler)
        alert.addAction(btnRemove)
        
        controller.present(alert, animated: true, completion: nil)
    }
    
}
