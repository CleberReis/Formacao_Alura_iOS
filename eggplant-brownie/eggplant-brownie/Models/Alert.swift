//
//  Alert.swift
//  eggplant-brownie
//
//  Created by Cleber Reis on 06/07/21.
//

import UIKit

class Alert {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(title: String = "Atenção", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(btnOK)
        controller.present(alert, animated: true, completion: nil)
    }
}
