//
//  MoreTableViewController.swift
//  embedded
//
//  Created by Pavel Ivanov on 12/2/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

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
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {       
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.getIdentifier(), for: indexPath) as? CustomTableViewCell {
            
            cell.saveDelegate = self
            cell.removeDelegate = self
            let user = itemArray[indexPath.row]
            cell.initCell(user: user)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "DetailStoryboard") as? DetailViewController else { return }
        detailViewController.user = itemArray[indexPath.row]
        show(detailViewController, sender: nil)
    }
}

//MARK: - CustomTableViewCellDelegate
extension MoreTableViewController: removeUserFromFavoriteDelegate, saveUserToFavoriteDelegate {
    
    func removeUserFromFavorite(idCell: IndexPath) {
        let user = itemArray[idCell.row]
        DataWork.deleteUser(userId: user.id)
        tableView.reloadData()        
    }
    
    func saveUserToFavorite(idCell: IndexPath) {
        let user = itemArray[idCell.row]
        DataWork.createData(newUser: user)
    }
}
