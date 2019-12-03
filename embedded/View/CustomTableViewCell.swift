//
//  CustomTableViewCell.swift
//  embedded
//
//  Created by Pavel Ivanov on 12/2/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

 protocol CustomTableViewCellDelegate {
    
     func didAddFavorite(idCell: IndexPath)
     func didRemoveFavorite(idCell: IndexPath)
}

class CustomTableViewCell: UITableViewCell {
    
    //MARK: - Outlet
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var favorite: UIButton!
    
    //MARK: - Variable
    var delegate: CustomTableViewCellDelegate?    
    
    class func getIdentifier() -> String {
        return "MoreCell"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Action
    @IBAction func favorite(_ sender: UIButton) {
        
        let view = self.superview as? UITableView
        guard let indexPath = view?.indexPath(for: self)else {return}
        
        if favorite.backgroundColor == .green {
            delegate?.didRemoveFavorite(idCell: indexPath)
            print("remove index \(indexPath.row) \(indexPath.section)")
            favorite.backgroundColor = .none
        } else {
            delegate?.didAddFavorite(idCell: indexPath)
            print("add index \(indexPath.row) \(indexPath.section)")
            favorite.backgroundColor = .green
        }
    }
    
    //MARK: - Init Cell
    func initCell(user: User) {
        
        guard let first_name = user.first_name else { return }
        guard let last_name = user.last_name else { return }
        
        let name = "\(first_name) \(last_name)"
        nameLabel.text = name
        detailLabel.text = user.email
        
        if DataWork.checkConsistUser(userId: user.id!) {
            favorite.backgroundColor = .green
        } else {
            favorite.backgroundColor = .none
        }
    }
}
