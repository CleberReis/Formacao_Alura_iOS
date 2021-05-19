//
//  AddItensViewController.swift
//  eggplant-brownie
//
//  Created by Cleber Reis on 18/05/21.
//

import UIKit

protocol AddItensDelegate {
    func add(_ item: Item)
}

class AddItensViewController: UIViewController {
    
    // MARK: - Properties
    var delegate: AddItensDelegate?
    
    init(delegate: AddItensDelegate) {
        super.init(nibName: "AddItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var caloriesTextField: UITextField!
    
    // MARK: - Super Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - IBAction
    @IBAction func addItem(_ sender: Any) {
        
        guard let nameTextField = nameTextField.text, let calories = caloriesTextField.text else {
            return
        }
        
        if let numberCalories = Double(calories) {
            let item = Item(nome: nameTextField, calorias: numberCalories)
            delegate?.add(item)
            
            navigationController?.popViewController(animated: true)
        }
        
    }
    
}
