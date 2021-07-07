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
    
    override func viewDidLoad() {
        guard let path = recoveryPath() else { return }
        do {
            let data = try Data(contentsOf: path)
            guard let mealsSaved = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<Meal> else {
                return
            }
            
            meals = mealsSaved
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func recoveryPath() -> URL? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let path = directory.appendingPathComponent("meal")
        
        return path
    }
    
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
        cell.textLabel?.text = meal.name
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showDetails))
        cell.addGestureRecognizer(longPress)

        return cell
    }
    
    @objc func showDetails(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let cell = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let meal = meals[indexPath.row]
                        
            RemoveMealController.init(controller: self).showMeal(meal) { alert in
                self.meals.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
            
        }
    }
    
}

extension MealTableViewController: AddMealDelegate {
    
    func add(_ meal: Meal) {
        meals.append(meal)
        
        guard let path = recoveryPath() else { return }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: meal, requiringSecureCoding: false)
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
}
