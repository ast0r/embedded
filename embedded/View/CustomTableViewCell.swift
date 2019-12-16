//
//  CustomTableViewCell.swift
//  embedded
//
//  Created by Pavel Ivanov on 12/2/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

protocol saveUserToFavoriteDelegate {
    func saveUserToFavorite(idCell: IndexPath)
}

protocol removeUserFromFavoriteDelegate {
    func removeUserFromFavorite(idCell: IndexPath)
}

class CustomTableViewCell: UITableViewCell {
    
    //MARK: - Outlet
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var favorite: UIButton!
    
    
    //MARK: - Variable
    var saveDelegate: saveUserToFavoriteDelegate?
    var removeDelegate: removeUserFromFavoriteDelegate?
    var isChecked = false
    
    class func getIdentifier() -> String {
        return "MoreCell"
    }
    
    //MARK: - Action
    @IBAction func favorite(_ sender: UIButton) {
        
        //get indexPath from tableView for cell
        let view = self.superview as? UITableView
        guard let indexPath = view?.indexPath(for: self) else {return}
        
        if isChecked {
            removeDelegate?.removeUserFromFavorite(idCell: indexPath)
            let imageNotFill = UIImage(systemName: "star")
            favorite.setImage(imageNotFill, for: .normal)
            isChecked = false
            
        } else {
            saveDelegate?.saveUserToFavorite(idCell: indexPath)
            let imageFill = UIImage(systemName: "star.fill")
            favorite.setImage(imageFill, for: .normal)
            isChecked = true
            
        }
    }
    
    //MARK: - Init Cell
    func initCell(user: User) {        
        if DataWork.checkConsistUser(userId: user.id) {
            let imageFill = UIImage(systemName: "star.fill")
            favorite.setImage(imageFill, for: .normal)
            isChecked = true
        } else {
            let imageNotFill = UIImage(systemName: "star")
            favorite.setImage(imageNotFill, for: .normal)
            isChecked = false
        }
        
        guard let first_name = user.first_name else { return }
        guard let last_name = user.last_name else { return }
        
        let name = "\(first_name) \(last_name)"
        nameLabel.text = name
        detailLabel.text = user.email
        
        guard let imageUrl = DataWork.getImageUrl(urlString: user.avatar) else {return}
        DispatchQueue.main.async {
            self.photoImage.af_setImage(withURL: imageUrl)
        }
    }
}
