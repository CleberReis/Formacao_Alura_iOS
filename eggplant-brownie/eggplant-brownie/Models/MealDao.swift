//
//  MealDao.swift
//  eggplant-brownie
//
//  Created by Cleber Reis on 06/07/21.
//

import Foundation

class MealDao {
    
    func save(_ meal: [Meal]) {
        guard let path = recoveryPath() else { return }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: meal, requiringSecureCoding: false)
            try data.write(to: path)
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
    
    func recovery() -> [Meal] {
        guard let path = recoveryPath() else { return [] }
        do {
            let data = try Data(contentsOf: path)
            guard let mealsSaved = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Meal] else { return [] }
            return mealsSaved
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
}
