//
//  TableViewController.swift
//  ContactBook
//
//  Created by Виталий Крюков on 23.07.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
  
    var persistance = PersistanceContact()
 
    @IBAction func addButtom(_ sender: Any) {

        let alertPhoneController = UIAlertController(title: "Add phone number ", message: nil, preferredStyle: .alert)
        alertPhoneController.addTextField { textField in
            textField.placeholder = "New name"
        }
        alertPhoneController.addTextField { textField in
            textField.placeholder = "New phone number"
        }
        
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { (alert) in
        }
        
        let alertAction2 = UIAlertAction(title: "Add", style: .cancel) { (alert) in
        
            let number = alertPhoneController.textFields![1].text
            let name = alertPhoneController.textFields![0].text
            
            if number == "" || name == ""{
                
            }
            else {
                self.persistance.addRealm(addNumber: number!, addName: name!)
            }
            
            self.persistance.loadRealm()
            self.tableView.reloadData()
        }
        
        alertPhoneController.addAction(alertAction1)
        alertPhoneController.addAction(alertAction2)
        present(alertPhoneController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.persistance.loadRealm()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistance.allData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "book", for: indexPath) as! TableViewCell
        
        cell.nameLabel.text = persistance.allData[indexPath.row].name
        cell.phoneLabel.text = persistance.allData[indexPath.row].phoneNumber
                
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
      
            persistance.deleteRealm(delete: persistance.allData[indexPath.row])
            persistance.loadRealm()
            tableView.reloadData()
        }
    }

    
    func callNumber(number: String) {
        if let url = URL(string: "tel://\(number)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:]) { success in
                    print(success)}
            }
           else {
            let success = UIApplication.shared.openURL(url)
            print(success)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        callNumber(number: persistance.allData[indexPath.row].phoneNumber)
    }
}
