//
//  MoreTableViewController.swift
//  embedded
//
//  Created by Pavel Ivanov on 12/2/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit
import CoreData

class MoreTableViewController: UITableViewController {

    //MARK: - Variable
    var itemArray = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetch()        
    }
    
    func fetch() {
        FetchData.fetch { (data) in
            DispatchQueue.main.async {
                self.itemArray = data.data
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.getIdentifier(), for: indexPath) as? CustomTableViewCell {
            
            cell.delegate = self
            let user = itemArray[indexPath.row]
            cell.initCell(user: user)
            
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: - CustomTableViewCellDelegate

extension MoreTableViewController: CustomTableViewCellDelegate {
    
    func didRemoveFavorite(idCell: IndexPath) {
        print("did tap button favorite \(idCell.row)")
                
        let user = itemArray[idCell.row]
        DataWork.deleteUser(userId: user.id!)
        tableView.reloadData()
        
        print("remove \(user.id!) \(user.first_name!)")
    }
    
    func didAddFavorite(idCell: IndexPath) {
        
        let user = itemArray[idCell.row]
        DataWork.createData(newUser: user)
    }
}
