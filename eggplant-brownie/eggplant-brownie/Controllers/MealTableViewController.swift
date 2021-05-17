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

        return cell
    }
    
}

extension MealTableViewController: AddMealDelegate {
    
    func add(_ meal: Meal) {
        meals.append(meal)
        tableView.reloadData()
    }
    
}
