//
//  NameTableViewController.swift
//  KobayashiMaruTake2
//
//  Created by Clarissa Vinciguerra on 11/2/20.
//

import UIKit

class NameTableViewController: UITableViewController {
 
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        NameController.shared.loadFromPersistenceStore()
        tableView.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        addNameAlert()
    }
    
    @IBAction func randomizeButtonTapped(_ sender: Any) {
        NameController.shared.namesArray.shuffle()
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if NameController.shared.namesArray.count % 2 == 0 {
            return NameController.shared.namesArray.count / 2
        } else {
            return NameController.shared.namesArray.count / 2 + 1
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)

        if NameController.shared.namesArray.count % 2 == 0 {
            let name = NameController.shared.namesArray[indexPath.row + indexPath.section * 2]
            cell.textLabel?.text = name.name
            return cell
        }
        
        if (indexPath.row + indexPath.section * 2) < NameController.shared.namesArray.count {
            let name = NameController.shared.namesArray[indexPath.row + indexPath.section * 2]
            cell.textLabel?.text = name.name
        } else {
            cell.textLabel?.text = ""
        }
        return cell
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let name = NameController.shared.namesArray[indexPath.row + indexPath.section * 2]
            NameController.shared.deleteName(nameToDelete: name)
            tableView.reloadData()
        }
    }
    
    // MARK: - Class Methods
    
    func addNameAlert() {
        let alertController = UIAlertController(title: "Add Name", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter name here..."
        }
        
        let addNameAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else { return }
            print("TextFromAlert: \(text)")
            NameController.shared.addNameToArray(name: text)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(addNameAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
} // End of Class
