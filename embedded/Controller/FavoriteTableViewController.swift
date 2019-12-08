//
//  FavoriteTableViewController.swift
//  embedded
//
//  Created by Pavel Ivanov on 12/2/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit
import CoreData

class FavoriteTableViewController: UITableViewController {
    
    //MARK: - Variable
    var favoriteUsers : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteUsers = DataWork.fetchAllData()
        self.tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoriteUsers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.getIdentifier(), for: indexPath) as? CustomTableViewCell {
            let user = favoriteUsers[indexPath.row]
            cell.initCell(user: user)
            cell.delegate = self
            //cell.favorite.backgroundColor = .green
            return cell
        }
        return UITableViewCell()
    }
}

 //MARK: -CustomTableViewCellDelegate

extension FavoriteTableViewController: CustomTableViewCellDelegate {
    
    func didAddFavorite(idCell: IndexPath) {
       
    }

    func didRemoveFavorite(idCell: IndexPath) {
        print("did tap button favorite \(idCell.row)")
                
        let user = favoriteUsers[idCell.row]
        DataWork.deleteUser(userId: user.id!)
        favoriteUsers.remove(at: idCell.row)
        tableView.reloadData()
        
        print("remove \(user.id!) \(user.first_name!)")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
               guard let detailViewController = storyboard.instantiateViewController(identifier: "DetailStoryboard") as? DetailViewController else { return }
           detailViewController.user = favoriteUsers[indexPath.row]
               
               show(detailViewController, sender: nil)
           }
}
