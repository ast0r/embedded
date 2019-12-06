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
        
        if DataWork.checkConsistUser(userId: user.id!) {
            favorite.backgroundColor = .green
        } else {
            favorite.backgroundColor = .none
        }
        
        guard let first_name = user.first_name else { return }
        guard let last_name = user.last_name else { return }
        
        let name = "\(first_name) \(last_name)"
        nameLabel.text = name
        detailLabel.text = user.email
        
        guard let imageUrl = getImageUrl(urlString: user.avatar) else {return}
        DispatchQueue.main.async {
            self.photoImage.af_setImage(withURL: imageUrl)
        }
    }
    
    func getImageUrl(urlString: String?) -> URL? {
        
        if let imageUrlString = urlString {
            let urlImage = URL(string: imageUrlString)
            return urlImage
        }
        return nil        
    }

}

//extension String {
//    func toImage() -> UIImage? {
//        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
//            return UIImage(data: data)
//        }
//        return nil
//    }
//}
