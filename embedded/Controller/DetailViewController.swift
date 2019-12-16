//
//  DetailViewController.swift
//  embedded
//
//  Created by Pavel Ivanov on 12/2/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Variable
    var user = User()    
    var isChecked = false
    
    //MARK: - Outlets
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var nameTextLabel: UILabel!    
    @IBOutlet weak var detailTextLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDetail(user: user)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initDetail(user: user)
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        if isChecked == true {
            DataWork.deleteUser(userId: user.id)
            let imageNotFill = UIImage(systemName: "star")
            favoriteButton.setImage(imageNotFill, for: .normal)
            isChecked = false
            
        } else {
            DataWork.createData(newUser: user)
            let imageFill = UIImage(systemName: "star.fill")
            favoriteButton.setImage(imageFill, for: .normal)
            isChecked = true
        }
    }
    
    func initDetail(user: User) {
        guard let first_name = user.first_name else { return }
        guard let last_name = user.last_name else { return }
        
        nameTextLabel.text = "\(first_name) \(last_name)"
        detailTextLabel.text = user.email
        
        guard let imageUrl = DataWork.getImageUrl(urlString: user.avatar) else {return}
        DispatchQueue.main.async {
            self.photoImage.af_setImage(withURL: imageUrl)
        }
        
        if DataWork.checkConsistUser(userId: user.id) {
            let imageFill = UIImage(systemName: "star.fill")
            favoriteButton.setImage(imageFill, for: .normal)
            isChecked = true
        } else {
            let imageNotFill = UIImage(systemName: "star")
            favoriteButton.setImage(imageNotFill, for: .normal)
            isChecked = false
        }        
    }
}
