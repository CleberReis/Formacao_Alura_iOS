//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Cleber Reis on 10/05/21.
//

import UIKit

protocol AddMealDelegate {
    func add(_ meal: Meal)
}

class ViewController: UIViewController {
    
    // MARK: - Properties
    var delegate: AddMealDelegate?
    var itens: [Item] = [
        Item(nome: "Queijo", calorias: 40.0),
        Item(nome: "Molho apimentado", calorias: 30.0)
    ]
    
    var itensSelected: [Item] = []
    
    // MARK: - @IBOutlet
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var happyTextField: UITextField?
    @IBOutlet weak var itensTableView: UITableView?
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnAddItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self , action: #selector(addItem))
        navigationItem.rightBarButtonItem = btnAddItem
        
        do {
            guard let diretory = recoveryDirectory() else { return }
            let data = try Data(contentsOf: diretory)
            let itensSaved = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Item]
            itens = itensSaved
        } catch {
            print(error.localizedDescription)
        }
        
        
        
        
    }
    
    // MARK: - Methods
    @objc func addItem() {
        let addViewController = AddItensViewController(delegate: self)
        navigationController?.pushViewController(addViewController, animated: true)
    }
    
    func recoveryMealForm() -> Meal? {
        guard let nameMeal = nameTextField?.text else {
            return nil
        }
        guard let happyMeal = happyTextField?.text, let happy = Int(happyMeal) else {
            return nil
        }
        
        let meal = Meal(nome: nameMeal, felicidade: happy, itens: itensSelected)
        
        return meal
    }
    
    // MARK: - @IBAction
    @IBAction func addMeal(_ sender: UIButton) {
        
        if let meal = recoveryMealForm() {
            delegate?.add(meal)
            navigationController?.popViewController(animated: true)
        } else {
            Alert.init(controller: self).show(message: "Erro ao ler dados do formulário")
        }
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let item = itens[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.selectionStyle = .none
        
        if cell.accessoryType == .none {
            
            cell.accessoryType = .checkmark
            itensSelected.append(itens[indexPath.row])
        } else {
            cell.accessoryType = .none
            let item = itens[indexPath.row]
            if let position = itensSelected.firstIndex(of: item) {
                itensSelected.remove(at: position)
            }
        }
    }
}

// MARK: - AddItensDelegate
extension ViewController: AddItensDelegate {
    func add(_ item: Item) {
        itens.append(item)
        
        if let tableView = itensTableView {
            tableView.reloadData()
        } else {
            Alert(controller: self).show(title: "Desculpe", message: "Não foi possível atualizar a tabela")
        }
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
    
}
