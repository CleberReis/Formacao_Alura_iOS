//
//  ItenDao.swift
//  eggplant-brownie
//
//  Created by Cleber Reis on 06/07/21.
//

import Foundation

class ItemDao {
    func save(_ itens: [Item]) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            guard let path = recoveryDirectory() else { return }
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recoveryDirectory() -> URL? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let path = directory.appendingPathComponent("itens")
        
        return path
    }
    
    func recovery() -> [Item] {
        do {
            guard let diretory = recoveryDirectory() else { return [] }
            let data = try Data(contentsOf: diretory)
            let itensSaved = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Item]
            return itensSaved
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
