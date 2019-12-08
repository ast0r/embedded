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
    var isChecked = false
    
    class func getIdentifier() -> String {
        return "MoreCell"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    //MARK: - Action
    @IBAction func favorite(_ sender: UIButton) {
        
        //get indexPath from tableView for cell
        let view = self.superview as? UITableView
        guard let indexPath = view?.indexPath(for: self)else {return}
        
        if isChecked == true {
            delegate?.didRemoveFavorite(idCell: indexPath)
            print("remove index \(indexPath.row) \(indexPath.section)")
            let imageNotFill = UIImage(systemName: "star")
            favorite.setImage(imageNotFill, for: .normal)
            isChecked = false
            
        } else {
            delegate?.didAddFavorite(idCell: indexPath)
            print("add index \(indexPath.row) \(indexPath.section)")
            let imageFill = UIImage(systemName: "star.fill")
            favorite.setImage(imageFill, for: .normal)
            isChecked = true
            
        }
    }
    
    //MARK: - Init Cell
    func initCell(user: User) {        
        if DataWork.checkConsistUser(userId: user.id!) {
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
    
//    func getImageUrl(urlString: String?) -> URL? {
//        if let imageUrlString = urlString {
//            let urlImage = URL(string: imageUrlString)
//            return urlImage
//        }
//        return nil        
//    }
}
