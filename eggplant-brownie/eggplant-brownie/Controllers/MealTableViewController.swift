//
//  MealTableViewController.swift
//  eggplant-brownie
//
//  Created by Cleber Reis on 10/05/21.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    var meals = [
        Meal(nome: "Feijoada", felicidade: 5),
        Meal(nome: "Arroz", felicidade: 3),
        Meal(nome: "Pizza", felicidade: 5)
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addSegue" {
            if let viewController = segue.destination as? ViewController {
                viewController.delegate = self
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meal = meals[indexPath.row]

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = meal.nome
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showDetails))
        cell.addGestureRecognizer(longPress)

        return cell
    }
    
    @objc func showDetails(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let cell = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let meal = meals[indexPath.row]
            
            let alert = UIAlertController(title: meal.nome, message: meal.detail(), preferredStyle: .alert)
            let btnOK = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(btnOK)
            
            present(alert, animated: true, completion: nil)
            
        }
    }
    
}

extension MealTableViewController: AddMealDelegate {
    
    func add(_ meal: Meal) {
        meals.append(meal)
        tableView.reloadData()
    }
    
}
